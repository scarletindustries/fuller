//// State for the render in progress: the component React is calling right
//// now, so hooks can reach React without threading Arc's state through the
//// user's code, and the React context objects made so far.

import arc/bytecode/key
import arc/host.{type Context}
import arc/rt/obj as rt_obj
import arc/rt/types.{type JsVal, StringKey, mk_undefined}
import gleam/dict.{type Dict}
import gleam/dynamic.{type Dynamic}
import gleam/option.{type Option, None, Some}

/// React's hooks and `createContext`, read once at boot.
pub type React {
  React(
    use_id: JsVal,
    use_context: JsVal,
    use_state: JsVal,
    create_context: JsVal,
  )
}

/// The JS values converting elements needs. Kept apart from the booted
/// engine so the component functions that hold it stay small: Arc's garbage
/// collector walks everything a host function holds.
pub type Js {
  Js(create_element: JsVal, fragment: JsVal, react: React)
}

/// The component React is calling right now.
pub type Frame {
  Frame(ctx: Context(Dynamic), react: React)
}

@external(erlang, "fuller_ffi", "coerce")
pub fn to_dynamic(value: a) -> Dynamic

@external(erlang, "fuller_ffi", "coerce")
pub fn from_dynamic(value: Dynamic) -> a

@external(erlang, "fuller_ffi", "pdict_put")
fn pdict_put(key: String, value: a) -> Nil

@external(erlang, "fuller_ffi", "pdict_get")
fn pdict_get(key: String) -> Option(a)

@external(erlang, "fuller_ffi", "pdict_erase")
fn pdict_erase(key: String) -> Nil

const frame_key = "frame"

const contexts_key = "contexts"

const components_key = "components"

/// Forget any state a previous render left behind, for example after a
/// component panicked.
pub fn reset() -> Nil {
  pdict_erase(frame_key)
  pdict_put(contexts_key, dict.new())
  pdict_put(components_key, dict.new())
}

/// The JS function React calls for components named `name`, made on first
/// use. One function per name, like a React component type; each element
/// passes its own render function in its props.
pub fn component_function(
  ctx: Context(Dynamic),
  name: String,
  impl: host.HostFn(Dynamic),
) -> #(JsVal, Context(Dynamic)) {
  let components: Dict(String, JsVal) = case pdict_get(components_key) {
    Some(components) -> components
    None -> dict.new()
  }
  case dict.get(components, name) {
    Ok(function) -> #(function, ctx)
    Error(Nil) -> {
      let #(function, ctx) = host.function(ctx, name, 1, impl)
      pdict_put(components_key, dict.insert(components, name, function))
      #(function, ctx)
    }
  }
}

/// Runs `render` as the current component and returns its result with the
/// state the hooks it called left behind.
pub fn with_frame(frame: Frame, render: fn() -> a) -> #(a, Context(Dynamic)) {
  let previous: Option(Frame) = pdict_get(frame_key)
  pdict_put(frame_key, frame)
  let result = render()
  let ctx = case pdict_get(frame_key) {
    Some(Frame(ctx:, ..)) -> ctx
    None -> frame.ctx
  }
  case previous {
    Some(previous) -> pdict_put(frame_key, previous)
    None -> pdict_erase(frame_key)
  }
  #(result, ctx)
}

/// The current component's frame, for a hook. Panics outside a component,
/// like React's "Invalid hook call".
pub fn hook(name: String) -> Frame {
  case pdict_get(frame_key) {
    Some(frame) -> frame
    None ->
      panic as {
        "fuller: "
        <> name
        <> " can only be called inside a component (after `use <- component.named(...)`)"
      }
  }
}

/// Stores the state a hook left behind.
pub fn update(frame: Frame, ctx: Context(Dynamic)) -> Nil {
  pdict_put(frame_key, Frame(..frame, ctx:))
}

/// A Gleam value as a JS object React can hold and hand back unchanged.
pub fn wrap(ctx: Context(Dynamic), value: a) -> #(JsVal, Context(Dynamic)) {
  host.alloc_host_object(ctx, to_dynamic(value), None)
}

/// The Gleam value inside a JS object made by `wrap`.
pub fn unwrap(ctx: Context(Dynamic), value: JsVal, what: String) -> a {
  case host.read_host(ctx, value) {
    Some(inner) -> from_dynamic(inner)
    None -> panic as { "fuller: " <> what <> " is not a Gleam value" }
  }
}

/// The React context object for the fuller context `name`, made on first
/// use with `default` as its default value.
pub fn context_object(
  ctx: Context(Dynamic),
  react: React,
  name: String,
  default: Dynamic,
) -> #(Result(JsVal, JsVal), Context(Dynamic)) {
  let contexts: Dict(String, JsVal) = case pdict_get(contexts_key) {
    Some(contexts) -> contexts
    None -> dict.new()
  }
  case dict.get(contexts, name) {
    Ok(object) -> #(Ok(object), ctx)
    Error(Nil) -> {
      let #(default, ctx) = wrap(ctx, default)
      case host.call(ctx, react.create_context, mk_undefined(), [default]) {
        #(Ok(object), ctx) -> {
          pdict_put(contexts_key, dict.insert(contexts, name, object))
          #(Ok(object), ctx)
        }
        failed -> failed
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
