//// Helpers for turning fuller elements into React elements: the JS values
//// a render needs, Gleam values carried through React, and the per-render
//// table of component functions and context objects.

import arc/bytecode/key
import arc/host.{type Context}
import arc/rt/obj as rt_obj
import arc/rt/types.{type JsVal, KUndef, StringKey, mk_undefined}
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
/// engine so the component functions that hold it stay small: Arc's garbage
/// collector walks everything a host function holds.
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
pub fn component_function(
  ctx: Context(Dynamic),
  js: Js,
  name: String,
  impl: host.HostFn(Dynamic),
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  use ctx <- cached(ctx, js, "component " <> name)
  let #(function, ctx) = host.function(ctx, name, 1, impl)
  #(Ok(function), ctx)
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
/// the value itself first; one function per render serves every such call,
/// so no hook allocates a function of its own.
pub fn returning(
  ctx: Context(Dynamic),
  js: Js,
  value: JsVal,
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  let ctx = set(ctx, js.table, "pending value", value)
  use ctx <- cached(ctx, js, "pending value function")
  let #(function, ctx) =
    host.function(ctx, "fuller", 0, fn(ctx, _args, _this) {
      let #(value, ctx) = get(ctx, js.table, "pending value")
      #(Ok(value), ctx)
    })
  #(Ok(function), ctx)
}
