//// Hooks: things a component asks React for while it renders. Use them
//// with `use`, after `use <- component.named(...)`:
////
//// ```gleam
//// pub fn card(title title: String) -> Element {
////   use <- component.named("Card")
////   use id <- hook.use_id()
////   use theme <- hook.use_context(theme)
////   html.section([attribute.aria_labelledby(id)], [
////     html.h2([attribute.id(id)], [html.text(title)]),
////   ])
//// }
//// ```
////
//// A hook does not call React itself. It returns an element that asks
//// React when the component renders, then renders the rest of the function
//// with the answer. That keeps hooks pure: there is no hidden "current
//// component" anywhere. A hook outside a component fails the render with a
//// `TypeError`.
////
//// The server renders each component once and never re-renders, so state
//// never changes there: `use_state` and `use_reducer` give their initial
//// value, and their setters do nothing.
////
//// [React reference](https://react.dev/reference/react/hooks)

import fuller/context.{type Context}
import fuller/element.{type Element, Hook, UseContext, UseId, UseState}
import fuller/internal/render

/// A unique id for this component instance, stable between the server and
/// a client that hydrates the HTML. Use it to link elements, such as a
/// label and its input, or `aria_labelledby` and a heading, without
/// clashing when the component appears more than once.
///
/// ```gleam
/// pub fn field(label label: String) -> Element {
///   use <- component.named("Field")
///   use id <- hook.use_id()
///   html.div([], [
///     html.label([attribute.for(id)], [html.text(label)]),
///     html.input([attribute.id(id)]),
///   ])
/// }
/// ```
///
/// [React reference](https://react.dev/reference/react/useId)
pub fn use_id(next: fn(String) -> Element) -> Element {
  Hook(UseId, fn(id) { next(render.from_dynamic(id)) })
}

/// The value of `context` from the nearest `context.provide` above this
/// component, or the context's default when there is none.
///
/// ```gleam
/// use theme <- hook.use_context(theme)
/// ```
///
/// [React reference](https://react.dev/reference/react/useContext)
pub fn use_context(context: Context(a), next: fn(a) -> Element) -> Element {
  Hook(
    UseContext(
      context: context.name,
      default: render.to_dynamic(context.default),
    ),
    fn(value) { next(render.from_dynamic(value)) },
  )
}

/// A state value and a function to change it. On the server the value is
/// always `initial` and the setter does nothing, because nothing
/// re-renders; it is here so the same component can be hydrated later.
///
/// ```gleam
/// use count, _set_count <- hook.use_state(0)
/// ```
///
/// [React reference](https://react.dev/reference/react/useState)
pub fn use_state(initial: a, next: fn(a, fn(a) -> Nil) -> Element) -> Element {
  Hook(UseState(render.to_dynamic(initial)), fn(state) {
    next(render.from_dynamic(state), fn(_) { Nil })
  })
}

/// State updated by a reducer, like `use_state` with the update logic in
/// one place. On the server the state is always `initial` and `dispatch`
/// does nothing.
///
/// ```gleam
/// use count, _dispatch <- hook.use_reducer(fn(n, add) { n + add }, 0)
/// ```
///
/// [React reference](https://react.dev/reference/react/useReducer)
pub fn use_reducer(
  _reducer: fn(state, action) -> state,
  initial: state,
  next: fn(state, fn(action) -> Nil) -> Element,
) -> Element {
  use state, _set <- use_state(initial)
  next(state, fn(_) { Nil })
}
