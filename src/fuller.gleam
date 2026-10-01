//// Render React elements built in Gleam to HTML on the BEAM.
////
//// fuller runs unmodified React 19 and its synchronous server renderer,
//// compiled to Erlang by Arc. Build elements with `fuller/element/html`,
//// `fuller/element/svg` and `fuller/attribute`, boot React once with `new`,
//// and render with `render_to_string` or `render_to_static_markup`.
////
//// ```gleam
//// import fuller
//// import fuller/attribute
//// import fuller/element/html
////
//// pub fn main() {
////   let renderer = fuller.new()
////   let page =
////     html.div([attribute.class("app")], [
////       html.h1([], [html.text("Hello from the BEAM")]),
////     ])
////   let assert Ok(markup) = fuller.render_to_string(renderer, page)
////   // <div class="app"><h1>Hello from the BEAM</h1></div>
//// }
//// ```

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
import fuller/element.{
  type Element, Component, Element, Fragment, None, Provider, Text,
}
import fuller/internal/render
import gleam/dynamic.{type Dynamic}
import gleam/list
import gleam/result
import gleam/string

/// A booted copy of React and react-dom/server, ready to render.
///
/// Make one with `new` and reuse it. It is an immutable value, so it is safe
/// to keep in a global or share between processes; each render starts from
/// the same booted state and none of them affect the others.
pub opaque type Renderer {
  Renderer(
    engine: Engine(Dynamic),
    js: render.Js,
    render_to_string: JsVal,
    render_to_static_markup: JsVal,
  )
}

/// Why a render failed.
pub type RenderError {
  /// React threw while rendering, or returned something that is not a
  /// string. `message` is the JavaScript error, formatted with its stack
  /// when there is one.
  ReactThrew(message: String)
}

/// Boots React and returns a `Renderer`.
///
/// This runs React's top-level code once, which takes on the order of 100
/// ms, so call it at startup and reuse the result for every render rather
/// than creating one per request.
///
/// Panics if React's top-level code throws, which would mean the bundled
/// module is broken rather than anything about your elements.
///
/// ```gleam
/// let renderer = fuller.new()
/// let assert Ok(html) =
///   fuller.render_to_string(renderer, html.p([], [html.text("Hi")]))
/// ```
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
      let #(use_id, st) = get(st, react, "useId")
      let #(use_context, st) = get(st, react, "useContext")
      let #(use_state, st) = get(st, react, "useState")
      let #(create_context, st) = get(st, react, "createContext")
      #(
        Renderer(
          engine: engine,
          js: render.Js(
            create_element:,
            fragment:,
            react: render.React(
              use_id:,
              use_context:,
              use_state:,
              create_context:,
            ),
          ),
          render_to_string:,
          render_to_static_markup:,
        ),
        Context(..ctx, agent: st),
      )
    })
  Renderer(..exports, engine:)
}

/// Renders an element to HTML that client-side React can hydrate.
///
/// The output carries what hydration needs, such as `<!-- -->` markers
/// between adjacent text nodes, so the browser can attach React to it
/// without re-rendering. When nothing on the client will hydrate the page,
/// `render_to_static_markup` gives smaller, cleaner HTML.
///
/// This is React's synchronous renderer: it does not stream, and it does not
/// wait for data, so a suspended component renders its nearest fallback.
///
/// ```gleam
/// fuller.render_to_string(renderer, html.h1([], [html.text("Hello "), html.text("Gleam")]))
/// // -> Ok("<h1>Hello <!-- -->Gleam</h1>")
/// ```
///
/// [React reference](https://react.dev/reference/react-dom/server/renderToString)
pub fn render_to_string(
  renderer: Renderer,
  element: Element,
) -> Result(String, RenderError) {
  render_with(renderer, renderer.render_to_string, element)
}

/// Renders an element to plain HTML, without anything hydration needs.
///
/// Use it for pages no client-side React will take over: emails, static
/// pages, server-only HTML. The output cannot be hydrated.
///
/// ```gleam
/// fuller.render_to_static_markup(renderer, html.p([], [html.text("a"), html.text("b")]))
/// // -> Ok("<p>ab</p>")
/// ```
///
/// [React reference](https://react.dev/reference/react-dom/server/renderToStaticMarkup)
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
  render.reset()
  let #(outcome, engine) =
    engine.with_context(renderer.engine, fn(ctx) {
      use el, ctx <- then(to_js(ctx, renderer.js, element))
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
  #(Result(a, JsVal), Context(Dynamic))

fn then(step: Step(a), k: fn(a, Context(Dynamic)) -> Step(b)) -> Step(b) {
  let #(result, ctx) = step
  case result {
    Ok(v) -> k(v, ctx)
    Error(thrown) -> #(Error(thrown), ctx)
  }
}

fn to_js(
  ctx: Context(Dynamic),
  js: render.Js,
  element: Element,
) -> Step(JsVal) {
  case element {
    Text(content) -> #(Ok(mk_string(content)), ctx)
    None -> #(Ok(mk_null()), ctx)
    Fragment(children) -> {
      use kids, ctx <- then(children_to_js(ctx, js, children))
      host.call(ctx, js.create_element, mk_undefined(), [
        js.fragment,
        mk_null(),
        ..kids
      ])
    }
    Component(name, render_fn) -> {
      let #(function, ctx) =
        render.component_function(ctx, name, fn(ctx, args, _this) {
          render_component(js, ctx, args)
        })
      let #(render_fn, ctx) = render.wrap(ctx, render_fn)
      let #(props, ctx) = host.object(ctx, [#("render", render_fn)])
      host.call(ctx, js.create_element, mk_undefined(), [function, props])
    }
    Provider(context, default, value, children) -> {
      use object, ctx <- then(render.context_object(
        ctx,
        js.react,
        context,
        default,
      ))
      let #(value, ctx) = render.wrap(ctx, value)
      let #(props, ctx) = host.object(ctx, [#("value", value)])
      use kids, ctx <- then(children_to_js(ctx, js, children))
      host.call(ctx, js.create_element, mk_undefined(), [object, props, ..kids])
    }
    Element(tag, attributes, children) -> {
      let #(props, ctx) = props_to_js(ctx, attributes)
      let children = join_text_children(tag, children)
      use kids, ctx <- then(children_to_js(ctx, js, children))
      host.call(ctx, js.create_element, mk_undefined(), [
        mk_string(tag),
        props,
        ..kids
      ])
    }
  }
}

/// React renders `<title>`, `<style>` and `<script>` empty when they get
/// more than one child, so text children built up in pieces are joined into
/// one string first.
fn join_text_children(tag: String, children: List(Element)) -> List(Element) {
  case tag, children {
    "title", [_, _, ..] | "style", [_, _, ..] | "script", [_, _, ..] ->
      list.try_map(children, fn(child) {
        case child {
          Text(content) -> Ok(content)
          _ -> Error(Nil)
        }
      })
      |> result.map(fn(parts) { [Text(string.concat(parts))] })
      |> result.unwrap(children)
    _, _ -> children
  }
}

/// What React calls for a component: reads the element's render function
/// from its props and runs it as the current component.
fn render_component(
  js: render.Js,
  ctx: Context(Dynamic),
  args: List(JsVal),
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  let props = case args {
    [props, ..] -> props
    [] -> mk_undefined()
  }
  let #(render_fn, ctx) = render.get(ctx, props, "render")
  let render_fn: fn() -> Element = render.unwrap(ctx, render_fn, "a component")
  let frame = render.Frame(ctx:, react: js.react)
  let #(element, ctx) = render.with_frame(frame, render_fn)
  to_js(ctx, js, element)
}

fn children_to_js(
  ctx: Context(Dynamic),
  js: render.Js,
  children: List(Element),
) -> Step(List(JsVal)) {
  let #(reversed, ctx) =
    list.fold(children, #(Ok([]), ctx), fn(acc, child) {
      use done, ctx <- then(acc)
      use v, ctx <- then(to_js(ctx, js, child))
      #(Ok([v, ..done]), ctx)
    })
  #(result.map(reversed, list.reverse), ctx)
}

fn props_to_js(
  ctx: Context(Dynamic),
  attributes: List(Attribute),
) -> #(JsVal, Context(Dynamic)) {
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
  ctx: Context(Dynamic),
  attribute: Attribute,
) -> #(#(String, JsVal), Context(Dynamic)) {
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
