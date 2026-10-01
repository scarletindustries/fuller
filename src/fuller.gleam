import arc/bytecode/key
import arc/engine.{type Engine}
import arc/host.{type Context, Context}
import arc/rt/inspect as rt_inspect
import arc/rt/obj as rt_obj
import arc/rt/types.{
  type Agent, type JsVal, type JsValKind, JFloat, JInt, KBig, KBool, KHandle,
  KNull, KNum, KStr, KSym, KTdz, KUndef, StringKey, mk_bool, mk_null, mk_number,
  mk_string, mk_undefined,
}
import fuller/attribute.{
  type Attribute, Attribute, BoolAttribute, FloatAttribute, InnerHtml,
  IntAttribute, Style,
}
import fuller/element.{type Element, Element, Fragment, None, Text}
import gleam/list
import gleam/result

pub opaque type Renderer {
  Renderer(
    engine: Engine(Nil),
    create_element: JsVal,
    fragment: JsVal,
    render_to_string: JsVal,
    render_to_static_markup: JsVal,
  )
}

pub type RenderError {
  ReactThrew(message: String)
}

pub fn new() -> Renderer {
  let engine = engine.new()
  let #(exports, engine) =
    engine.with_context(engine, fn(ctx) {
      let #(exports, st) = case boot(ctx.agent) {
        Booted(exports, st) -> #(exports, st)
        Threw(thrown, st) ->
          panic as {
            "fuller: React's top level threw: "
            <> rt_inspect.format_error(st, thrown)
          }
      }
      let #(react, st) = get(st, exports, "React")
      let #(create_element, st) = get(st, react, "createElement")
      let #(fragment, st) = get(st, react, "Fragment")
      let #(render_to_string, st) = get(st, exports, "renderToString")
      let #(render_to_static_markup, st) =
        get(st, exports, "renderToStaticMarkup")
      #(
        #(create_element, fragment, render_to_string, render_to_static_markup),
        Context(..ctx, agent: st),
      )
    })
  let #(create_element, fragment, render_to_string, render_to_static_markup) =
    exports
  Renderer(
    engine:,
    create_element:,
    fragment:,
    render_to_string:,
    render_to_static_markup:,
  )
}

/// HTML with hydration markers
pub fn render_to_string(
  renderer: Renderer,
  element: Element,
) -> Result(String, RenderError) {
  render_with(renderer, renderer.render_to_string, element)
}

/// Plain HTML
pub fn render_to_static_markup(
  renderer: Renderer,
  element: Element,
) -> Result(String, RenderError) {
  render_with(renderer, renderer.render_to_static_markup, element)
}

@external(erlang, "fuller_ffi", "boot")
fn boot(st: Agent) -> Boot

type Boot {
  Booted(exports: JsVal, st: Agent)
  Threw(thrown: JsVal, st: Agent)
}

fn get(st: Agent, obj: JsVal, name: String) -> #(JsVal, Agent) {
  rt_obj.get_prop(st, obj, StringKey(key.canonical(name)))
}

fn render_with(
  renderer: Renderer,
  render_fn: JsVal,
  element: Element,
) -> Result(String, RenderError) {
  let #(outcome, engine) =
    engine.with_context(renderer.engine, fn(ctx) {
      use el, ctx <- then(to_js(ctx, renderer, element))
      host.call(ctx, render_fn, mk_undefined(), [el])
    })
  case outcome {
    Ok(markup) ->
      case types.classify(markup) {
        KStr(html) -> Ok(html)
        other ->
          Error(ReactThrew(
            "renderToString returned a non-string: "
            <> engine.inspect(engine, markup)
            <> " ("
            <> kind_name(other)
            <> ")",
          ))
      }
    Error(thrown) -> Error(ReactThrew(engine.format_error(engine, thrown)))
  }
}

fn kind_name(kind: JsValKind) -> String {
  case kind {
    KUndef -> "undefined"
    KNull -> "null"
    KBool(_) -> "boolean"
    KNum(_) -> "number"
    KStr(_) -> "string"
    KHandle(_) -> "object"
    KSym(_) -> "symbol"
    KBig(_) -> "bigint"
    KTdz -> "uninitialized"
  }
}

type Step(a) =
  #(Result(a, JsVal), Context(Nil))

fn then(step: Step(a), k: fn(a, Context(Nil)) -> Step(b)) -> Step(b) {
  let #(result, ctx) = step
  case result {
    Ok(v) -> k(v, ctx)
    Error(thrown) -> #(Error(thrown), ctx)
  }
}

fn to_js(
  ctx: Context(Nil),
  renderer: Renderer,
  element: Element,
) -> Step(JsVal) {
  case element {
    Text(content) -> #(Ok(mk_string(content)), ctx)
    None -> #(Ok(mk_null()), ctx)
    Fragment(children) -> {
      use kids, ctx <- then(children_to_js(ctx, renderer, children))
      host.call(ctx, renderer.create_element, mk_undefined(), [
        renderer.fragment,
        mk_null(),
        ..kids
      ])
    }
    Element(tag, attributes, children) -> {
      let #(props, ctx) = props_to_js(ctx, attributes)
      use kids, ctx <- then(children_to_js(ctx, renderer, children))
      host.call(ctx, renderer.create_element, mk_undefined(), [
        mk_string(tag),
        props,
        ..kids
      ])
    }
  }
}

fn children_to_js(
  ctx: Context(Nil),
  renderer: Renderer,
  children: List(Element),
) -> Step(List(JsVal)) {
  let #(reversed, ctx) =
    list.fold(children, #(Ok([]), ctx), fn(acc, child) {
      use done, ctx <- then(acc)
      use v, ctx <- then(to_js(ctx, renderer, child))
      #(Ok([v, ..done]), ctx)
    })
  #(result.map(reversed, list.reverse), ctx)
}

fn props_to_js(
  ctx: Context(Nil),
  attributes: List(Attribute),
) -> #(JsVal, Context(Nil)) {
  case attributes {
    [] -> #(mk_null(), ctx)
    _ -> {
      let #(props, ctx) =
        list.fold(attributes, #([], ctx), fn(acc, attribute) {
          let #(props, ctx) = acc
          let #(prop, ctx) = prop_to_js(ctx, attribute)
          #([prop, ..props], ctx)
        })
      host.object(ctx, list.reverse(props))
    }
  }
}

fn prop_to_js(
  ctx: Context(Nil),
  attribute: Attribute,
) -> #(#(String, JsVal), Context(Nil)) {
  case attribute {
    Attribute(name, value) -> #(#(name, mk_string(value)), ctx)
    IntAttribute(name, value) -> #(#(name, mk_number(JInt(value))), ctx)
    FloatAttribute(name, value) -> #(#(name, mk_number(JFloat(value))), ctx)
    BoolAttribute(name, value) -> #(#(name, mk_bool(value)), ctx)
    Style(properties) -> {
      let #(style, ctx) =
        host.object(ctx, list.map(properties, fn(p) { #(p.0, mk_string(p.1)) }))
      #(#("style", style), ctx)
    }
    InnerHtml(html) -> {
      let #(inner, ctx) = host.object(ctx, [#("__html", mk_string(html))])
      #(#("dangerouslySetInnerHTML", inner), ctx)
    }
  }
}
