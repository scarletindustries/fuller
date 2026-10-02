//// Helpers for turning fuller elements into React elements: the JS values
//// a render needs, Gleam values carried through React, and the per-render
//// table of component functions and context objects.

import arc/bytecode/key
import arc/host.{type Context}
import arc/rt/obj as rt_obj
import arc/rt/types.{type JsVal, KUndef, StringKey, mk_string, mk_undefined}
import gleam/dynamic.{type Dynamic}
import gleam/option.{None, Some}

/// React's hooks, `createContext` and `Suspense`, read once at boot.
pub type React {
  React(
    use_id: JsVal,
    use_context: JsVal,
    use_state: JsVal,
    use_memo: JsVal,
    use_callback: JsVal,
    use_ref: JsVal,
    use_deferred_value: JsVal,
    use_transition: JsVal,
    use_optimistic: JsVal,
    use_effect: JsVal,
    use_layout_effect: JsVal,
    use_insertion_effect: JsVal,
    use_sync_external_store: JsVal,
    create_context: JsVal,
    suspense: JsVal,
  )
}

/// The JS values converting elements needs. Kept apart from the booted
/// engine so the host function that holds it stays small: Arc's garbage
/// collector walks everything a host function holds.
///
/// Arc never frees a host function, so fuller makes its two once, at boot:
/// `component` is what React ends up calling for every component, and
/// `first_argument` returns its first argument. Whatever a render needs from
/// them it gets with `bind`, `Function.prototype.bind`, which makes an
/// ordinary JS function.
///
/// `table` is a plain JS object made fresh for each render, holding the
/// component functions and context objects made so far, so the same name
/// always gets the same one. `in_component` is whether React is calling a
/// component right now, which is the only time hooks may run.
pub type Js {
  Js(
    create_element: JsVal,
    fragment: JsVal,
    react: React,
    bind: JsVal,
    component: JsVal,
    first_argument: JsVal,
    table: JsVal,
    in_component: Bool,
  )
}

@external(erlang, "fuller_ffi", "coerce")
pub fn to_dynamic(value: a) -> Dynamic

@external(erlang, "fuller_ffi", "coerce")
pub fn from_dynamic(value: Dynamic) -> a

/// A Gleam value as a JS object React can hold and hand back unchanged.
pub fn wrap(ctx: Context(Dynamic), value: a) -> #(JsVal, Context(Dynamic)) {
  host.alloc_host_object(ctx, to_dynamic(value), None)
}

/// The Gleam value inside a JS object made by `wrap`, or a thrown
/// `TypeError` if it is not one.
pub fn unwrap(
  ctx: Context(Dynamic),
  value: JsVal,
  what: String,
) -> #(Result(a, JsVal), Context(Dynamic)) {
  case host.read_host(ctx, value) {
    Some(inner) -> #(Ok(from_dynamic(inner)), ctx)
    None -> {
      let #(thrown, ctx) =
        host.type_error(ctx, "fuller: " <> what <> " is not a Gleam value")
      case thrown {
        Error(thrown) -> #(Error(thrown), ctx)
        Ok(value) -> #(Error(value), ctx)
      }
    }
  }
}

/// Reads `name` off a JS object.
pub fn get(
  ctx: Context(Dynamic),
  object: JsVal,
  name: String,
) -> #(JsVal, Context(Dynamic)) {
  let #(value, agent) =
    rt_obj.get_prop(ctx.agent, object, StringKey(key.canonical(name)))
  #(value, host.Context(..ctx, agent:))
}

fn set(
  ctx: Context(Dynamic),
  object: JsVal,
  name: String,
  value: JsVal,
) -> Context(Dynamic) {
  let #(_written, agent) =
    rt_obj.set_prop(ctx.agent, object, StringKey(key.canonical(name)), value)
  host.Context(..ctx, agent:)
}

/// The value at `name` in this render's table, made with `make` and stored
/// on first use.
fn cached(
  ctx: Context(Dynamic),
  js: Js,
  name: String,
  make: fn(Context(Dynamic)) -> #(Result(JsVal, JsVal), Context(Dynamic)),
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  let #(found, ctx) = get(ctx, js.table, name)
  case types.classify(found) {
    KUndef ->
      case make(ctx) {
        #(Ok(value), ctx) -> #(Ok(value), set(ctx, js.table, name, value))
        failed -> failed
      }
    _ -> #(Ok(found), ctx)
  }
}

/// The JS function React calls for components named `name`. One function
/// per name, like a React component type; each element passes its own
/// render function in its props.
///
/// It is `js.component` bound to itself and this render's table, which that
/// function gets ahead of the props React passes. React reads the name off
/// `displayName`.
pub fn component_function(
  ctx: Context(Dynamic),
  js: Js,
  name: String,
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  use ctx <- cached(ctx, js, "component " <> name)
  case
    host.call(ctx, js.bind, js.component, [
      mk_undefined(),
      js.component,
      js.table,
    ])
  {
    #(Ok(function), ctx) -> #(
      Ok(function),
      set(ctx, function, "displayName", mk_string(name)),
    )
    failed -> failed
  }
}

/// The React context object for the fuller context `name`, with `default`
/// as its default value.
pub fn context_object(
  ctx: Context(Dynamic),
  js: Js,
  name: String,
  default: Dynamic,
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  use ctx <- cached(ctx, js, "context " <> name)
  let #(default, ctx) = wrap(ctx, default)
  host.call(ctx, js.react.create_context, mk_undefined(), [default])
}

/// A JS function that returns `value`, for hooks that take a function React
/// calls straight away (`useMemo`, `useSyncExternalStore`). fuller computes
/// the value itself first.
pub fn returning(
  ctx: Context(Dynamic),
  js: Js,
  value: JsVal,
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  host.call(ctx, js.bind, js.first_argument, [mk_undefined(), value])
}
