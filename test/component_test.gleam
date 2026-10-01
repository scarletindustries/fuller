import fuller
import fuller/attribute
import fuller/component
import fuller/context
import fuller/element.{type Element}
import fuller/element/html
import fuller/hook
import gleam/int
import gleam/string

pub type Theme {
  Light
  Dark
}

pub const theme = context.Context(name: "theme", default: Light)

fn render(el: Element) {
  fuller.render_to_static_markup(fuller.new(), el)
}

fn theme_name(theme: Theme) -> String {
  case theme {
    Light -> "light"
    Dark -> "dark"
  }
}

fn greeting(name name: String) -> Element {
  use <- component.named("Greeting")
  html.p([], [html.text("Hello, " <> name)])
}

fn themed() -> Element {
  use <- component.named("Themed")
  use current <- hook.use_context(theme)
  html.span([], [html.text(theme_name(current))])
}

fn field(label label: String) -> Element {
  use <- component.named("Field")
  use id <- hook.use_id()
  html.div([], [
    html.label([attribute.for(id)], [html.text(label)]),
    html.input([attribute.id(id)]),
  ])
}

fn counter() -> Element {
  use <- component.named("Counter")
  use count, _set <- hook.use_state(41)
  use total, _dispatch <- hook.use_reducer(fn(n, add) { n + add }, 1)
  html.p([], [html.text(int.to_string(count + total))])
}

pub fn component_renders_its_props_test() {
  assert render(html.div([], [greeting(name: "Gleam"), greeting(name: "BEAM")]))
    == Ok("<div><p>Hello, Gleam</p><p>Hello, BEAM</p></div>")
}

pub fn context_default_without_provider_test() {
  assert render(themed()) == Ok("<span>light</span>")
}

pub fn context_provided_value_test() {
  assert render(context.provide(theme, Dark, [themed()]))
    == Ok("<span>dark</span>")
}

pub fn inner_provider_overrides_outer_test() {
  let el =
    context.provide(theme, Dark, [
      themed(),
      context.provide(theme, Light, [themed()]),
    ])
  assert render(el) == Ok("<span>dark</span><span>light</span>")
}

pub fn nested_component_reads_context_test() {
  let outer = fn() {
    use <- component.named("Outer")
    html.div([], [themed()])
  }
  assert render(context.provide(theme, Dark, [outer()]))
    == Ok("<div><span>dark</span></div>")
}

pub fn use_id_is_unique_per_instance_test() {
  let assert Ok(html) =
    render(html.form([], [field(label: "A"), field(label: "B")]))
  assert html
    == "<form><div><label for=\"_R_1_\">A</label><input id=\"_R_1_\"/></div><div><label for=\"_R_2_\">B</label><input id=\"_R_2_\"/></div></form>"
}

pub fn use_state_and_reducer_return_initial_test() {
  assert render(counter()) == Ok("<p>42</p>")
}

pub fn renders_are_independent_test() {
  let r = fuller.new()
  assert fuller.render_to_static_markup(
      r,
      context.provide(theme, Dark, [themed()]),
    )
    == Ok("<span>dark</span>")
  assert fuller.render_to_static_markup(r, themed()) == Ok("<span>light</span>")
}

pub fn hook_outside_component_is_a_render_error_test() {
  let el = {
    use id <- hook.use_id()
    html.p([attribute.id(id)], [])
  }
  let assert Error(fuller.ReactThrew(message)) = render(el)
  assert string.contains(message, "hooks can only be used inside a component")
}

pub fn several_hooks_in_order_test() {
  let el = {
    use <- component.named("Many")
    use a <- hook.use_id()
    use current <- hook.use_context(theme)
    use count, _set <- hook.use_state(1)
    use b <- hook.use_id()
    html.p([attribute.id(a), attribute.title(b)], [
      html.text(theme_name(current) <> int.to_string(count)),
    ])
  }
  assert render(context.provide(theme, Dark, [el]))
    == Ok("<p id=\"_R_0_\" title=\"_R_0H1_\">dark1</p>")
}
