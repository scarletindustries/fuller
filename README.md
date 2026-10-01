<img width="128" src="https://github.com/scarletindustries.png" />

### fuller

React server rendering from Gleam. [Arc](https://github.com/alii/arc) compiles `react-dom/server` to Erlang, so React runs as a `.beam` on your node.

[Arc](https://arc.alistair.sh) • [Documentation](https://scarlet.industries)

---

> [!WARNING]
> Fuller is very experimental. It is big and slow, and it gets faster as Carder and Arc emit better Erlang.

```gleam
import fuller
import fuller/attribute
import fuller/element/html

pub fn main() {
  let renderer = fuller.new()
  let page =
    html.div([attribute.class("app")], [
      html.h1([], [html.text("Hello from the BEAM")]),
    ])
  let assert Ok(markup) = fuller.render_to_string(renderer, page)
  // <div class="app"><h1>Hello from the BEAM</h1></div>
}
```

`fuller.new()` boots React once and returns a `Renderer`, an immutable value that is safe to share across processes. `render_to_string` returns HTML that client React can hydrate, and `render_to_static_markup` returns plain HTML. A 200 row table takes about 13 ms to render on a MacBook. `gleam run -m example` runs a longer example.

#### Components, context and hooks

A component is a function whose first line is `use <- component.named("Name")`. Its arguments are its props, and React calls the rest while rendering. Hooks are `use` steps after that line:

```gleam
import fuller/component
import fuller/context
import fuller/hook

pub type Theme {
  Light
  Dark
}

pub const theme = context.Context(name: "theme", default: Light)

pub fn card(title title: String) -> Element {
  use <- component.named("Card")
  use id <- hook.use_id()
  use current <- hook.use_context(theme)
  let class = case current {
    Light -> "card"
    Dark -> "card dark"
  }
  html.section([attribute.class(class), attribute.aria_labelledby(id)], [
    html.h2([attribute.id(id)], [html.text(title)]),
  ])
}

context.provide(theme, Dark, [card(title: "Hello"), card(title: "Again")])
```

`fuller/hook` has `use_id`, `use_context`, `use_state`, `use_reducer`, `use_memo`, `use_callback`, `use_ref`, `use_deferred_value`, `use_transition`, `use_optimistic`, `use_sync_external_store` and the effect hooks, and `element.suspense` makes a `<Suspense>` boundary. The server renders each component once, so state stays at its initial value and effects never run. A component costs about 12 µs more than a plain function.

#### How it works

`scripts/build.sh` bundles `js/entry.js`, which imports unmodified React 19 and its synchronous server renderer, into one script with Bun. Arc's AOT compiler turns that script into `src/fuller_react_dom_server.erl`, a checked-in file of about 5 MB.

`fuller/element/html` and `fuller/element/svg` cover the HTML and SVG elements, and `fuller/attribute` and `fuller/attribute/svg` the attributes. Function names follow HTML and lustre (`readonly`, `tabindex`, `stroke_width`) and set React's props (`readOnly`, `tabIndex`, `strokeWidth`). The streaming renderers need web APIs Arc does not have yet (`MessageChannel`, `ReadableStream`, `TextEncoder`), and client side hydration does not exist yet.

To regenerate the Erlang, with an Arc checkout next to this one:

```sh
ARC_DIR=../arc scripts/build.sh
```
