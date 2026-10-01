//// Components: Gleam functions React calls while rendering, so they can use
//// hooks from `fuller/hook` and read context from `fuller/context`.
////
//// Mark a function as a component with `use <- component.named("Name")` as
//// its first line. Its arguments are its props, and callers use it like any
//// other function that returns an `Element`:
////
//// ```gleam
//// import fuller/attribute
//// import fuller/component
//// import fuller/element.{type Element}
//// import fuller/element/html
//// import fuller/hook
////
//// pub fn card(title title: String, body body: String) -> Element {
////   use <- component.named("Card")
////   let id = hook.use_id()
////   html.section([attribute.aria_labelledby(id)], [
////     html.h2([attribute.id(id)], [html.text(title)]),
////     html.p([], [html.text(body)]),
////   ])
//// }
////
//// html.main([], [card(title: "Hello", body: "From Gleam")])
//// ```
////
//// A plain function that returns an `Element` is also fine, and a little
//// faster; make it a component when it needs hooks or context.

import fuller/element.{type Element, Component}

/// Makes the rest of the function a React component named `name`.
///
/// Everything after `use <- component.named("Name")` runs when React
/// reaches this component in the tree, not when the function is called, so
/// hooks work there. `name` is what React shows in error messages and stack
/// traces.
///
/// ```gleam
/// pub fn greeting(name name: String) -> Element {
///   use <- component.named("Greeting")
///   html.p([], [html.text("Hello, " <> name)])
/// }
/// ```
///
/// [React reference](https://react.dev/learn/your-first-component)
pub fn named(name: String, render: fn() -> Element) -> Element {
  Component(name:, render:)
}
