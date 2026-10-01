//// Hooks: React features a component reads while it renders. Call them
//// only inside a component, after `use <- component.named(...)`; anywhere
//// else they panic, like React's "Invalid hook call".
////
//// The server renders each component once and never re-renders, so state
//// never changes there: `use_state` and `use_reducer` return their initial
//// value, and their setters do nothing.
////
//// [React reference](https://react.dev/reference/react/hooks)

import arc/host
import arc/rt/types.{KStr, mk_undefined}
import fuller/context.{type Context}
import fuller/internal/render
import gleam/string

/// A unique id for this component instance, stable between the server and
/// a client that hydrates the HTML. Use it to link elements, such as a
/// label and its input, or `aria_labelledby` and a heading, without
/// clashing when the component appears more than once.
///
/// ```gleam
/// pub fn field(label label: String) -> Element {
///   use <- component.named("Field")
///   let id = hook.use_id()
///   html.div([], [
///     html.label([attribute.for(id)], [html.text(label)]),
///     html.input([attribute.id(id)]),
///   ])
/// }
/// ```
///
/// [React reference](https://react.dev/reference/react/useId)
pub fn use_id() -> String {
  let frame = render.hook("use_id")
  let #(result, ctx) =
    host.call(frame.ctx, frame.react.use_id, mk_undefined(), [])
  render.update(frame, ctx)
  case result {
    Ok(id) ->
      case types.classify(id) {
        KStr(id) -> id
        other -> panic as { "fuller: useId returned " <> string.inspect(other) }
      }
    Error(thrown) ->
      panic as { "fuller: useId threw " <> string.inspect(thrown) }
  }
}

/// The value of `context` from the nearest `context.provide` above this
/// component, or the context's default when there is none.
///
/// ```gleam
/// let theme = hook.use_context(theme)
/// ```
///
/// [React reference](https://react.dev/reference/react/useContext)
pub fn use_context(context: Context(a)) -> a {
  let frame = render.hook("use_context")
  let #(object, ctx) =
    render.context_object(
      frame.ctx,
      frame.react,
      context.name,
      render.to_dynamic(context.default),
    )
  let #(result, ctx) = case object {
    Ok(object) ->
      host.call(ctx, frame.react.use_context, mk_undefined(), [object])
    Error(thrown) -> #(Error(thrown), ctx)
  }
  render.update(frame, ctx)
  case result {
    Ok(value) -> render.unwrap(ctx, value, "a context value")
    Error(thrown) ->
      panic as { "fuller: useContext threw " <> string.inspect(thrown) }
  }
}

/// A state value and a function to change it. On the server the value is
/// always `initial`, and the setter does nothing, because nothing
/// re-renders; it is here so the same component can be hydrated later.
///
/// ```gleam
/// let #(count, _set_count) = hook.use_state(0)
/// ```
///
/// [React reference](https://react.dev/reference/react/useState)
pub fn use_state(initial: a) -> #(a, fn(a) -> Nil) {
  let frame = render.hook("use_state")
  let #(wrapped, ctx) = render.wrap(frame.ctx, initial)
  let #(result, ctx) =
    host.call(ctx, frame.react.use_state, mk_undefined(), [wrapped])
  let #(value, ctx) = case result {
    Ok(pair) -> render.get(ctx, pair, "0")
    Error(thrown) ->
      panic as { "fuller: useState threw " <> string.inspect(thrown) }
  }
  render.update(frame, ctx)
  #(render.unwrap(ctx, value, "a state value"), fn(_) { Nil })
}

/// State updated by a reducer, like `use_state` with the update logic in
/// one place. On the server the state is always `initial` and `dispatch`
/// does nothing.
///
/// ```gleam
/// let #(count, _dispatch) = hook.use_reducer(fn(n, msg) { case msg { Inc -> n + 1 } }, 0)
/// ```
///
/// [React reference](https://react.dev/reference/react/useReducer)
pub fn use_reducer(
  _reducer: fn(state, action) -> state,
  initial: state,
) -> #(state, fn(action) -> Nil) {
  let #(state, _set) = use_state(initial)
  #(state, fn(_) { Nil })
}
