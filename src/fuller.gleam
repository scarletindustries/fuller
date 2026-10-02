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
  type Element, Component, Element, Fragment, Hook, None, Provider, Suspense,
  Text, UseCallback, UseContext, UseDeferredValue, UseEffect, UseId, UseMemo,
  UseOptimistic, UseRef, UseState, UseSyncExternalStore, UseTransition,
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
      let #(jsx, st) = get(st, exports, "jsx")
      let #(fragment, st) = get(st, react, "Fragment")
      let #(render_to_string, st) = get(st, exports, "renderToString")
      let #(render_to_static_markup, st) =
        get(st, exports, "renderToStaticMarkup")
      let #(use_id, st) = get(st, react, "useId")
      let #(use_context, st) = get(st, react, "useContext")
      let #(use_state, st) = get(st, react, "useState")
      let #(use_memo, st) = get(st, react, "useMemo")
      let #(use_callback, st) = get(st, react, "useCallback")
      let #(use_ref, st) = get(st, react, "useRef")
      let #(use_deferred_value, st) = get(st, react, "useDeferredValue")
      let #(use_transition, st) = get(st, react, "useTransition")
      let #(use_optimistic, st) = get(st, react, "useOptimistic")
      let #(use_effect, st) = get(st, react, "useEffect")
      let #(use_layout_effect, st) = get(st, react, "useLayoutEffect")
      let #(use_insertion_effect, st) = get(st, react, "useInsertionEffect")
      let #(use_sync_external_store, st) =
        get(st, react, "useSyncExternalStore")
      let #(create_context, st) = get(st, react, "createContext")
      let #(suspense, st) = get(st, react, "Suspense")
      let #(bind, st) = get(st, jsx, "bind")
      let #(first_argument, ctx) =
        host.function(
          Context(..ctx, agent: st),
          "fuller",
          1,
          fn(ctx, args, _this) {
            #(Ok(list.first(args) |> result.unwrap(mk_undefined())), ctx)
          },
        )
      let js =
        render.Js(
          jsx:,
          fragment:,
          react: render.React(
            use_id:,
            use_context:,
            use_state:,
            use_memo:,
            use_callback:,
            use_ref:,
            use_deferred_value:,
            use_transition:,
            use_optimistic:,
            use_effect:,
            use_layout_effect:,
            use_insertion_effect:,
            use_sync_external_store:,
            create_context:,
            suspense:,
          ),
          bind:,
          component: mk_undefined(),
          first_argument:,
          table: mk_undefined(),
          in_component: False,
        )
      let #(component, ctx) =
        host.function(ctx, "fuller", 1, fn(ctx, args, _this) {
          render_component(js, ctx, args)
        })
      #(
        Renderer(
          engine: engine,
          js: render.Js(..js, component:),
          render_to_string:,
          render_to_static_markup:,
        ),
        ctx,
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
  let #(outcome, engine) =
    engine.with_context(renderer.engine, fn(ctx) {
      let #(table, ctx) = host.object(ctx, [])
      let js = render.Js(..renderer.js, table:, in_component: False)
      use el, ctx <- then(to_js(ctx, js, element))
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
      jsx(ctx, js, js.fragment, [], kids)
    }
    Component(name, render_fn) -> {
      use function, ctx <- then(render.component_function(ctx, js, name))
      let #(render_fn, ctx) = render.wrap(ctx, render_fn)
      jsx(ctx, js, function, [#("render", render_fn)], [])
    }
    Provider(context, default, value, children) -> {
      use object, ctx <- then(render.context_object(ctx, js, context, default))
      let #(value, ctx) = render.wrap(ctx, value)
      use kids, ctx <- then(children_to_js(ctx, js, children))
      jsx(ctx, js, object, [#("value", value)], kids)
    }
    Suspense(fallback, children) -> {
      use fallback, ctx <- then(to_js(ctx, js, fallback))
      use kids, ctx <- then(children_to_js(ctx, js, children))
      jsx(ctx, js, js.react.suspense, [#("fallback", fallback)], kids)
    }
    Hook(hook, next) ->
      case js.in_component {
        True -> {
          use answer, ctx <- then(run_hook(ctx, js, hook))
          to_js(ctx, js, next(answer))
        }
        False ->
          host.type_error(
            ctx,
            "fuller: hooks can only be used inside a component, after `use <- component.named(...)`",
          )
      }
    Element(tag, attributes, children) -> {
      let #(props, ctx) = props_to_js(ctx, attributes)
      let children = join_text_children(tag, children)
      use kids, ctx <- then(children_to_js(ctx, js, children))
      jsx(ctx, js, mk_string(tag), props, kids)
    }
  }
}

/// Makes a React element with `jsx` from `react/jsx-runtime`, the function
/// JSX compiles to. The children go in the props: one on its own, several as
/// an array.
fn jsx(
  ctx: Context(Dynamic),
  js: render.Js,
  type_: JsVal,
  props: List(#(String, JsVal)),
  kids: List(JsVal),
) -> Step(JsVal) {
  let #(props, ctx) = case kids {
    [] -> #(props, ctx)
    [only] -> #(list.append(props, [#("children", only)]), ctx)
    _ -> {
      let #(kids, ctx) = host.array(ctx, kids)
      #(list.append(props, [#("children", kids)]), ctx)
    }
  }
  let #(props, ctx) = host.object(ctx, props)
  host.call(ctx, js.jsx, mk_undefined(), [type_, props])
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
/// from its props and converts what it returns, with hooks allowed.
///
/// `render.component_function` binds the first two arguments, this function
/// itself and the render's table, which `booted` was made too early to hold.
fn render_component(
  booted: render.Js,
  ctx: Context(Dynamic),
  args: List(JsVal),
) -> Step(JsVal) {
  let #(component, table, props) = case args {
    [component, table, props, ..] -> #(component, table, props)
    _ -> #(mk_undefined(), mk_undefined(), mk_undefined())
  }
  let js = render.Js(..booted, component:, table:, in_component: True)
  let #(render_fn, ctx) = render.get(ctx, props, "render")
  use render_fn, ctx <- then(unwrap_component(ctx, render_fn))
  to_js(ctx, js, render_fn())
}

fn unwrap_component(
  ctx: Context(Dynamic),
  value: JsVal,
) -> Step(fn() -> Element) {
  render.unwrap(ctx, value, "a component")
}

/// Asks React for what `hook` wants, while it is calling a component.
fn run_hook(
  ctx: Context(Dynamic),
  js: render.Js,
  hook: element.Hook,
) -> Step(Dynamic) {
  case hook {
    UseId -> {
      use id, ctx <- then(host.call(ctx, js.react.use_id, mk_undefined(), []))
      case types.classify(id) {
        KStr(id) -> #(Ok(render.to_dynamic(id)), ctx)
        _ ->
          host_error(host.type_error(ctx, "fuller: useId returned a non-string"))
      }
    }
    UseContext(context, default) -> {
      use object, ctx <- then(render.context_object(ctx, js, context, default))
      use value, ctx <- then(
        host.call(ctx, js.react.use_context, mk_undefined(), [object]),
      )
      render.unwrap(ctx, value, "a context value")
    }
    UseState(initial) -> first_of(ctx, js.react.use_state, initial, "a state")
    UseOptimistic(state) ->
      first_of(ctx, js.react.use_optimistic, state, "an optimistic state")
    UseDeferredValue(value) ->
      round_trip(
        ctx,
        js.react.use_deferred_value,
        value,
        [],
        "a deferred value",
      )
    UseCallback(callback, deps) -> {
      let #(deps, ctx) = deps_array(ctx, deps)
      round_trip(ctx, js.react.use_callback, callback, [deps], "a callback")
    }
    UseMemo(compute, deps) -> {
      let #(value, ctx) = render.wrap(ctx, compute())
      use create, ctx <- then(render.returning(ctx, js, value))
      let #(deps, ctx) = deps_array(ctx, deps)
      use value, ctx <- then(
        host.call(ctx, js.react.use_memo, mk_undefined(), [create, deps]),
      )
      render.unwrap(ctx, value, "a memoized value")
    }
    UseRef(initial) -> {
      let #(initial, ctx) = render.wrap(ctx, initial)
      use ref, ctx <- then(
        host.call(ctx, js.react.use_ref, mk_undefined(), [initial]),
      )
      let #(current, ctx) = render.get(ctx, ref, "current")
      render.unwrap(ctx, current, "a ref value")
    }
    UseTransition -> {
      use pair, ctx <- then(
        host.call(ctx, js.react.use_transition, mk_undefined(), []),
      )
      let #(pending, ctx) = render.get(ctx, pair, "0")
      case types.classify(pending) {
        KBool(pending) -> #(Ok(render.to_dynamic(pending)), ctx)
        _ ->
          host_error(host.type_error(
            ctx,
            "fuller: useTransition returned a non-boolean",
          ))
      }
    }
    UseEffect(kind) -> {
      let hook = case kind {
        element.Effect -> js.react.use_effect
        element.LayoutEffect -> js.react.use_layout_effect
        element.InsertionEffect -> js.react.use_insertion_effect
      }
      use _nothing, ctx <- then(host.call(ctx, hook, mk_undefined(), []))
      #(Ok(render.to_dynamic(Nil)), ctx)
    }
    UseSyncExternalStore(get_server_snapshot) -> {
      let #(snapshot, ctx) = render.wrap(ctx, get_server_snapshot())
      use get, ctx <- then(render.returning(ctx, js, snapshot))
      use value, ctx <- then(
        host.call(ctx, js.react.use_sync_external_store, mk_undefined(), [
          mk_undefined(),
          mk_undefined(),
          get,
        ]),
      )
      render.unwrap(ctx, value, "a store snapshot")
    }
  }
}

/// Calls a hook that takes one Gleam value (plus `extra` JS arguments) and
/// returns one, and unwraps the result.
fn round_trip(
  ctx: Context(Dynamic),
  hook: JsVal,
  value: Dynamic,
  extra: List(JsVal),
  what: String,
) -> Step(Dynamic) {
  let #(value, ctx) = render.wrap(ctx, value)
  use result, ctx <- then(
    host.call(ctx, hook, mk_undefined(), [value, ..extra]),
  )
  render.unwrap(ctx, result, what)
}

/// Calls a hook that takes one Gleam value and returns a `[value, setter]`
/// pair, and unwraps the value.
fn first_of(
  ctx: Context(Dynamic),
  hook: JsVal,
  value: Dynamic,
  what: String,
) -> Step(Dynamic) {
  let #(value, ctx) = render.wrap(ctx, value)
  use pair, ctx <- then(host.call(ctx, hook, mk_undefined(), [value]))
  let #(first, ctx) = render.get(ctx, pair, "0")
  render.unwrap(ctx, first, what)
}

/// A hook's dependency array: `[deps]`, one Gleam value (often a tuple).
fn deps_array(
  ctx: Context(Dynamic),
  deps: Dynamic,
) -> #(JsVal, Context(Dynamic)) {
  let #(deps, ctx) = render.wrap(ctx, deps)
  host.array(ctx, [deps])
}

/// A thrown error as a failed step of any type.
fn host_error(thrown: #(Result(JsVal, JsVal), Context(Dynamic))) -> Step(a) {
  case thrown {
    #(Error(error), ctx) | #(Ok(error), ctx) -> #(Error(error), ctx)
  }
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
) -> #(List(#(String, JsVal)), Context(Dynamic)) {
  let #(props, ctx) =
    list.fold(attributes, #([], ctx), fn(acc, attribute) {
      let #(props, ctx) = acc
      let #(prop, ctx) = prop_to_js(ctx, attribute)
      #([prop, ..props], ctx)
    })
  #(list.reverse(props), ctx)
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
