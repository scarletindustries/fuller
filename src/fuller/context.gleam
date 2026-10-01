//// Context: a value a component provides to everything inside it, which
//// components below read with `hook.use_context`, without passing it down
//// through every function in between.
////
//// Define a context once as a module constant, give it a value with
//// `provide`, and read it in a component:
////
//// ```gleam
//// import fuller/component
//// import fuller/context
//// import fuller/element.{type Element}
//// import fuller/element/html
//// import fuller/hook
////
//// pub type Theme {
////   Light
////   Dark
//// }
////
//// pub const theme = context.Context(name: "theme", default: Light)
////
//// pub fn page() -> Element {
////   context.provide(theme, Dark, [button()])
//// }
////
//// fn button() -> Element {
////   use <- component.named("Button")
////   use current <- hook.use_context(theme)
////   case current {
////     Light -> html.button([], [html.text("Light")])
////     Dark -> html.button([], [html.text("Dark")])
////   }
//// }
//// ```
////
//// [React reference](https://react.dev/learn/passing-data-deeply-with-context)

import fuller/element.{type Element, Provider}
import fuller/internal/render

/// A context that holds a value of type `a`.
///
/// `name` identifies it within a render, so two contexts must not share a
/// name. `default` is what `hook.use_context` gives when no `provide` is
/// above the component reading it.
pub type Context(a) {
  Context(name: String, default: a)
}

/// Gives `children`, and everything inside them, `value` for `context`.
/// Components inside read it with `use value <- hook.use_context(context)`. An inner
/// `provide` for the same context overrides an outer one.
///
/// ```gleam
/// context.provide(theme, Dark, [sidebar(), content()])
/// ```
///
/// [React reference](https://react.dev/reference/react/createContext#provider)
pub fn provide(
  context: Context(a),
  value: a,
  children: List(Element),
) -> Element {
  Provider(
    context: context.name,
    default: render.to_dynamic(context.default),
    value: render.to_dynamic(value),
    children:,
  )
}
