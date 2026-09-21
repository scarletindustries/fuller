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

`fuller.new()` boots React once and returns a `Renderer`, an immutable value that is safe to share across processes. `render_to_string` returns HTML that client React can hydrate, and `render_to_static_markup` returns plain HTML. A 200 row table takes about 20 ms to render on a MacBook. `gleam run -m example` runs a longer example.

#### How it works

`scripts/build.sh` bundles `js/entry.js`, which imports unmodified React 19 and its synchronous server renderer, into one script with Bun. Arc's AOT compiler turns that script into `src/fuller_react_dom_server.erl`, a checked-in file of about 10 MB.

Gleam components with hooks and context work. The streaming renderers and client side hydration do not exist yet.

To regenerate the Erlang, with an Arc checkout next to this one:

```sh
ARC_DIR=../arc scripts/build.sh
```
