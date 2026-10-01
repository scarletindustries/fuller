import fuller
import fuller/attribute
import fuller/component
import fuller/context
import fuller/element.{type Element}
import fuller/element/html
import fuller/hook
import gleam/int

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
  html.span([], [html.text(theme_name(hook.use_context(theme)))])
}

fn field(label label: String) -> Element {
  use <- component.named("Field")
  let id = hook.use_id()
  html.div([], [
    html.label([attribute.for(id)], [html.text(label)]),
    html.input([attribute.id(id)]),
  ])
}

fn counter() -> Element {
  use <- component.named("Counter")
  let #(count, _set) = hook.use_state(41)
  let #(total, _dispatch) = hook.use_reducer(fn(n, add) { n + add }, 1)
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
