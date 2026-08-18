import arc/engine.{type Engine, type JsValue}
import arc/host
import arc/rt/inspect as rt_inspect
import arc/rt/obj as rt_obj
import arc/rt/types.{
  type Agent, JFloat, JInt, Named, StringKey, mk_bool, mk_null, mk_number,
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
    create_element: JsValue,
    fragment: JsValue,
    render_to_string: JsValue,
    render_to_static_markup: JsValue,
  )
}

pub type RenderError {
  ReactThrew(message: String)
}

pub fn new() -> Renderer {
  let engine = engine.new()
  let #(engine, exports) =
    engine.with_state(engine, fn(s) {
      let #(exports, st) = case boot(s.agent) {
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
        host.State(..s, agent: st),
        #(create_element, fragment, render_to_string, render_to_static_markup),
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
  Booted(exports: JsValue, st: Agent)
  Threw(thrown: JsValue, st: Agent)
}

fn get(st: Agent, obj: JsValue, name: String) -> #(JsValue, Agent) {
  rt_obj.t_get_prop(st, obj, StringKey(Named(name)))
}

fn render_with(
  renderer: Renderer,
  render_fn: JsValue,
  element: Element,
) -> Result(String, RenderError) {
  let #(engine, outcome) =
    engine.with_state(renderer.engine, fn(s) {
      use el, s <- then(to_js(s, renderer, element))
      host.call(s, render_fn, mk_undefined(), [el])
    })
  case outcome {
    Ok(markup) ->
      case engine.classify(markup) {
        engine.JsString(html) -> Ok(html)
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

fn kind_name(kind: engine.JsValueKind) -> String {
  case kind {
    engine.JsUndefined -> "undefined"
    engine.JsNull -> "null"
    engine.JsBool(_) -> "boolean"
    engine.JsNumber(_) -> "number"
    engine.JsString(_) -> "string"
    engine.JsObject(_) -> "object"
    engine.JsSymbol -> "symbol"
    engine.JsBigInt(_) -> "bigint"
  }
}

type Step(a) =
  #(host.State(Nil), Result(a, JsValue))

fn then(step: Step(a), k: fn(a, host.State(Nil)) -> Step(b)) -> Step(b) {
  let #(s, result) = step
  case result {
    Ok(v) -> k(v, s)
    Error(thrown) -> #(s, Error(thrown))
  }
}

fn to_js(
  s: host.State(Nil),
  renderer: Renderer,
  element: Element,
) -> Step(JsValue) {
  case element {
    Text(content) -> #(s, Ok(mk_string(content)))
    None -> #(s, Ok(mk_null()))
    Fragment(children) -> {
      use kids, s <- then(children_to_js(s, renderer, children))
      host.call(s, renderer.create_element, mk_undefined(), [
        renderer.fragment,
        mk_null(),
        ..kids
      ])
    }
    Element(tag, attributes, children) -> {
      let #(s, props) = props_to_js(s, attributes)
      use kids, s <- then(children_to_js(s, renderer, children))
      host.call(s, renderer.create_element, mk_undefined(), [
        mk_string(tag),
        props,
        ..kids
      ])
    }
  }
}

fn children_to_js(
  s: host.State(Nil),
  renderer: Renderer,
  children: List(Element),
) -> Step(List(JsValue)) {
  let #(s, reversed) =
    list.fold(children, #(s, Ok([])), fn(acc, child) {
      use done, s <- then(acc)
      use v, s <- then(to_js(s, renderer, child))
      #(s, Ok([v, ..done]))
    })
  #(s, result.map(reversed, list.reverse))
}

fn props_to_js(
  s: host.State(Nil),
  attributes: List(Attribute),
) -> #(host.State(Nil), JsValue) {
  case attributes {
    [] -> #(s, mk_null())
    _ -> {
      let #(s, props) =
        list.fold(attributes, #(s, []), fn(acc, attribute) {
          let #(s, props) = acc
          let #(s, prop) = prop_to_js(s, attribute)
          #(s, [prop, ..props])
        })
      host.object(s, list.reverse(props))
    }
  }
}

fn prop_to_js(
  s: host.State(Nil),
  attribute: Attribute,
) -> #(host.State(Nil), #(String, JsValue)) {
  case attribute {
    Attribute(name, value) -> #(s, #(name, mk_string(value)))
    IntAttribute(name, value) -> #(s, #(name, mk_number(JInt(value))))
    FloatAttribute(name, value) -> #(s, #(name, mk_number(JFloat(value))))
    BoolAttribute(name, value) -> #(s, #(name, mk_bool(value)))
    Style(properties) -> {
      let #(s, style) =
        host.object(s, list.map(properties, fn(p) { #(p.0, mk_string(p.1)) }))
      #(s, #("style", style))
    }
    InnerHtml(html) -> {
      let #(s, inner) = host.object(s, [#("__html", mk_string(html))])
      #(s, #("dangerouslySetInnerHTML", inner))
    }
  }
}
