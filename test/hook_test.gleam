import fuller
import fuller/component
import fuller/element.{type Element}
import fuller/element/html
import fuller/hook
import gleam/int

fn render(el: Element) {
  fuller.render_to_static_markup(fuller.new(), el)
}

fn text(s: String) -> Element {
  html.p([], [html.text(s)])
}

pub fn use_memo_runs_once_test() {
  let el = {
    use <- component.named("Memo")
    use total <- hook.use_memo(fn() { 1 + 2 + 3 }, #(1, 2))
    text(int.to_string(total))
  }
  assert render(el) == Ok("<p>6</p>")
}

pub fn use_callback_gives_the_callback_test() {
  let el = {
    use <- component.named("Callback")
    use double <- hook.use_callback(fn(n) { n * 2 }, Nil)
    text(int.to_string(double(21)))
  }
  assert render(el) == Ok("<p>42</p>")
}

pub fn use_ref_holds_initial_test() {
  let el = {
    use <- component.named("Ref")
    use ref <- hook.use_ref("start")
    text(hook.current(ref))
  }
  assert render(el) == Ok("<p>start</p>")
}

pub fn use_deferred_value_gives_value_test() {
  let el = {
    use <- component.named("Deferred")
    use value <- hook.use_deferred_value("query")
    text(value)
  }
  assert render(el) == Ok("<p>query</p>")
}

pub fn use_transition_is_not_pending_test() {
  let el = {
    use <- component.named("Transition")
    use pending, _start <- hook.use_transition()
    text(case pending {
      True -> "pending"
      False -> "idle"
    })
  }
  assert render(el) == Ok("<p>idle</p>")
}

pub fn use_optimistic_gives_state_test() {
  let el = {
    use <- component.named("Optimistic")
    use likes, _add <- hook.use_optimistic(7)
    text(int.to_string(likes))
  }
  assert render(el) == Ok("<p>7</p>")
}

pub fn effects_never_run_on_the_server_test() {
  let el = {
    use <- component.named("Effects")
    use <- hook.use_effect(fn() { panic as "effect ran" }, Nil)
    use <- hook.use_layout_effect(fn() { panic as "layout effect ran" }, Nil)
    use <- hook.use_insertion_effect(fn() { panic as "insertion ran" }, Nil)
    text("rendered")
  }
  assert render(el) == Ok("<p>rendered</p>")
}

pub fn use_sync_external_store_uses_server_snapshot_test() {
  let el = {
    use <- component.named("Store")
    use online <- hook.use_sync_external_store(
      subscribe: fn(_notify) { fn() { Nil } },
      get_snapshot: fn() { False },
      get_server_snapshot: fn() { True },
    )
    text(case online {
      True -> "online"
      False -> "offline"
    })
  }
  assert render(el) == Ok("<p>online</p>")
}

pub fn every_hook_in_one_component_test() {
  let el = {
    use <- component.named("All")
    use id <- hook.use_id()
    use a <- hook.use_memo(fn() { 1 }, Nil)
    use b, _ <- hook.use_state(2)
    use ref <- hook.use_ref(3)
    use <- hook.use_effect(fn() { Nil }, Nil)
    use c <- hook.use_deferred_value(4)
    use d <- hook.use_sync_external_store(
      subscribe: fn(_) { fn() { Nil } },
      get_snapshot: fn() { 0 },
      get_server_snapshot: fn() { 5 },
    )
    text(id <> " " <> int.to_string(a + b + hook.current(ref) + c + d))
  }
  assert render(el) == Ok("<p>_R_0_ 15</p>")
}

pub fn suspense_renders_children_test() {
  let el =
    element.suspense(text("loading"), [
      text("content"),
    ])
  assert render(el) == Ok("<p>content</p>")
  assert fuller.render_to_string(fuller.new(), el)
    == Ok("<!--$--><p>content</p><!--/$-->")
}
