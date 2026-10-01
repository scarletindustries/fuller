//// The `Element` type and the tag-independent builders. Per-tag helpers are
//// in `fuller/element/html` and `fuller/element/svg`.

import fuller/attribute.{type Attribute}
import gleam/dynamic.{type Dynamic}

/// Something React can render: an element, a text node, a fragment, or
/// nothing. Build them with the functions below, or with the per-tag
/// helpers in `fuller/element/html` and `fuller/element/svg`.
pub type Element {
  /// An HTML or SVG element: `tag` is the tag name as React expects it
  /// (`"div"`, `"linearGradient"`).
  Element(tag: String, attributes: List(Attribute), children: List(Element))
  /// A text node. React escapes it.
  Text(content: String)
  /// Several children with no wrapping element.
  Fragment(children: List(Element))
  /// Renders nothing.
  None
  /// A component: `render` runs inside React when it reaches this point in
  /// the tree, so hooks work in it. Made by `component.named`.
  Component(name: String, render: fn() -> Element)
  /// A `<Suspense>` boundary. Made by `suspense`.
  Suspense(fallback: Element, children: List(Element))
  /// A hook: asks React for something, then renders `next` with the
  /// answer. Made by the functions in `fuller/hook`.
  Hook(hook: Hook, next: fn(Dynamic) -> Element)
  /// Gives `children` a value for the context named `context`. Made by
  /// `context.provide`.
  Provider(
    context: String,
    default: Dynamic,
    value: Dynamic,
    children: List(Element),
  )
}

/// An element with any tag. Use it for tags fuller has no helper for, such
/// as custom elements (`"my-widget"`). The tag is passed to React unchanged.
///
/// ```gleam
/// element.element("my-widget", [attribute.attribute("size", "large")], [])
/// ```
///
/// [React reference](https://react.dev/reference/react/createElement)
pub fn element(
  tag: String,
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  Element(tag:, attributes:, children:)
}

/// A text node. React escapes `<`, `>`, `&` and quotes, so any string is safe
/// to put here. With `render_to_string`, React puts a `<!-- -->` marker
/// between two adjacent text nodes so hydration can tell them apart.
pub fn text(content: String) -> Element {
  Text(content:)
}

/// Groups children without adding a wrapping element to the HTML, like
/// React's `<>...</>`.
///
/// ```gleam
/// element.fragment([html.dt([], [html.text("Term")]), html.dd([], [html.text("Definition")])])
/// ```
///
/// [React reference](https://react.dev/reference/react/Fragment)
pub fn fragment(children: List(Element)) -> Element {
  Fragment(children:)
}

/// Renders nothing. Handy for conditionals:
///
/// ```gleam
/// case is_admin {
///   True -> html.a([attribute.href("/admin")], [html.text("Admin")])
///   False -> element.none()
/// }
/// ```
pub fn none() -> Element {
  None
}

/// What a `Hook` element asks React for.
pub type Hook {
  /// `useId()`, answered with a `String`.
  UseId
  /// `useContext` for the context named `context`, answered with its value.
  UseContext(context: String, default: Dynamic)
  /// `useState(initial)`, answered with the current state.
  UseState(initial: Dynamic)
  /// `useMemo(compute, [deps])`, answered with the computed value.
  UseMemo(compute: fn() -> Dynamic, deps: Dynamic)
  /// `useCallback(callback, [deps])`, answered with the callback.
  UseCallback(callback: Dynamic, deps: Dynamic)
  /// `useRef(initial)`, answered with the ref's `current`.
  UseRef(initial: Dynamic)
  /// `useDeferredValue(value)`, answered with the value.
  UseDeferredValue(value: Dynamic)
  /// `useTransition()`, answered with whether a transition is pending.
  UseTransition
  /// `useOptimistic(state)`, answered with the optimistic state.
  UseOptimistic(state: Dynamic)
  /// `useEffect`, `useLayoutEffect` or `useInsertionEffect`, answered with
  /// `Nil`. Effects never run on the server.
  UseEffect(kind: Effect)
  /// `useSyncExternalStore`, answered with `get_server_snapshot()`.
  UseSyncExternalStore(get_server_snapshot: fn() -> Dynamic)
}

/// Which effect hook a `UseEffect` is.
pub type Effect {
  Effect
  LayoutEffect
  InsertionEffect
}

/// A React `<Suspense>` boundary: renders `children`, or `fallback` in their
/// place if something inside suspends. fuller uses React's synchronous
/// renderer, which does not wait, so a suspending child always gets the
/// fallback. With `render_to_string` the boundary leaves `<!--$-->` and
/// `<!--/$-->` markers for hydration.
///
/// ```gleam
/// element.suspense(html.p([], [html.text("Loading...")]), [comments()])
/// ```
///
/// [React reference](https://react.dev/reference/react/Suspense)
pub fn suspense(fallback: Element, children: List(Element)) -> Element {
  Suspense(fallback:, children:)
}
