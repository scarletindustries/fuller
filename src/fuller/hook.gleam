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
//// value, and their setters do nothing. Effects never run on the server
//// either; `use_effect` and friends exist so the same component can be
//// hydrated later.
////
//// Hooks that take dependencies (`use_memo`, `use_callback`, the effects)
//// take one value; pass a tuple for several. They only matter on the
//// client, where React re-runs the hook when the value changes.
////
//// [React reference](https://react.dev/reference/react/hooks)

import fuller/context.{type Context}
import fuller/element.{
  type Element, Effect, Hook, InsertionEffect, LayoutEffect, UseCallback,
  UseContext, UseDeferredValue, UseEffect, UseId, UseMemo, UseOptimistic, UseRef,
  UseState, UseSyncExternalStore, UseTransition,
}
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

/// The result of `compute`, cached between client re-renders until `deps`
/// changes. The server renders once, so `compute` runs exactly once there.
/// Pass a tuple as `deps` for several dependencies.
///
/// ```gleam
/// use total <- hook.use_memo(fn() { list.fold(items, 0, int.add) }, items)
/// ```
///
/// [React reference](https://react.dev/reference/react/useMemo)
pub fn use_memo(
  compute: fn() -> a,
  deps: d,
  next: fn(a) -> Element,
) -> Element {
  Hook(
    UseMemo(
      compute: fn() { render.to_dynamic(compute()) },
      deps: render.to_dynamic(deps),
    ),
    fn(value) { next(render.from_dynamic(value)) },
  )
}

/// `callback`, kept the same function between client re-renders until
/// `deps` changes. On the server this is `callback` itself.
///
/// [React reference](https://react.dev/reference/react/useCallback)
pub fn use_callback(callback: f, deps: d, next: fn(f) -> Element) -> Element {
  Hook(
    UseCallback(
      callback: render.to_dynamic(callback),
      deps: render.to_dynamic(deps),
    ),
    fn(callback) { next(render.from_dynamic(callback)) },
  )
}

/// A ref: a value React keeps for the lifetime of the component without
/// re-rendering when it changes. On the server it holds `initial`.
///
/// ```gleam
/// use ref <- hook.use_ref(0)
/// html.p([], [html.text(int.to_string(hook.current(ref)))])
/// ```
///
/// [React reference](https://react.dev/reference/react/useRef)
pub fn use_ref(initial: a, next: fn(Ref(a)) -> Element) -> Element {
  Hook(UseRef(render.to_dynamic(initial)), fn(current) {
    next(Ref(current: render.from_dynamic(current)))
  })
}

/// A ref from `use_ref`.
pub opaque type Ref(a) {
  Ref(current: a)
}

/// The value a ref holds.
pub fn current(ref: Ref(a)) -> a {
  ref.current
}

/// A version of `value` that may lag behind on the client while something
/// more urgent renders. On the server it is `value`.
///
/// [React reference](https://react.dev/reference/react/useDeferredValue)
pub fn use_deferred_value(value: a, next: fn(a) -> Element) -> Element {
  Hook(UseDeferredValue(render.to_dynamic(value)), fn(value) {
    next(render.from_dynamic(value))
  })
}

/// Whether a transition is pending, and a function that starts one. On
/// the server nothing is pending, and starting a transition does nothing;
/// React does not allow it during server rendering.
///
/// ```gleam
/// use is_pending, _start <- hook.use_transition()
/// ```
///
/// [React reference](https://react.dev/reference/react/useTransition)
pub fn use_transition(
  next: fn(Bool, fn(fn() -> Nil) -> Nil) -> Element,
) -> Element {
  Hook(UseTransition, fn(pending) {
    next(render.from_dynamic(pending), fn(_) { Nil })
  })
}

/// State that can show an optimistic value while an action is in flight.
/// On the server it is `state`, and adding an optimistic value does
/// nothing.
///
/// [React reference](https://react.dev/reference/react/useOptimistic)
pub fn use_optimistic(
  state: a,
  next: fn(a, fn(a) -> Nil) -> Element,
) -> Element {
  Hook(UseOptimistic(render.to_dynamic(state)), fn(state) {
    next(render.from_dynamic(state), fn(_) { Nil })
  })
}

/// Runs `setup` after the component is shown on the client, again whenever
/// `deps` changes. Effects never run on the server, so there `setup` is
/// never called.
///
/// ```gleam
/// use <- hook.use_effect(fn() { track_view(page) }, page)
/// ```
///
/// [React reference](https://react.dev/reference/react/useEffect)
pub fn use_effect(
  _setup: fn() -> Nil,
  _deps: d,
  next: fn() -> Element,
) -> Element {
  Hook(UseEffect(Effect), fn(_) { next() })
}

/// Like `use_effect`, but runs before the browser paints. Never runs on the
/// server.
///
/// [React reference](https://react.dev/reference/react/useLayoutEffect)
pub fn use_layout_effect(
  _setup: fn() -> Nil,
  _deps: d,
  next: fn() -> Element,
) -> Element {
  Hook(UseEffect(LayoutEffect), fn(_) { next() })
}

/// Like `use_effect`, but runs before any layout effects, for CSS-in-JS
/// libraries injecting styles. Never runs on the server.
///
/// [React reference](https://react.dev/reference/react/useInsertionEffect)
pub fn use_insertion_effect(
  _setup: fn() -> Nil,
  _deps: d,
  next: fn() -> Element,
) -> Element {
  Hook(UseEffect(InsertionEffect), fn(_) { next() })
}

/// The current value of an external store. On the server React calls only
/// `get_server_snapshot`; `subscribe` and `get_snapshot` are for the
/// client.
///
/// ```gleam
/// use online <- hook.use_sync_external_store(
///   subscribe: network.subscribe,
///   get_snapshot: network.is_online,
///   get_server_snapshot: fn() { True },
/// )
/// ```
///
/// [React reference](https://react.dev/reference/react/useSyncExternalStore)
pub fn use_sync_external_store(
  subscribe _subscribe: fn(fn() -> Nil) -> fn() -> Nil,
  get_snapshot _get_snapshot: fn() -> a,
  get_server_snapshot get_server_snapshot: fn() -> a,
  next next: fn(a) -> Element,
) -> Element {
  Hook(
    UseSyncExternalStore(fn() { render.to_dynamic(get_server_snapshot()) }),
    fn(value) { next(render.from_dynamic(value)) },
  )
}
