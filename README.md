<img width="128" src="https://github.com/scarletindustries.png" />

### fuller

React server rendering from Gleam. `react-dom/server` is compiled to Erlang by [Arc](https://github.com/alii/arc), so React runs as a `.beam` on your node.

[Arc](https://arc.alistair.sh) • [Documentation](https://scarlet.industries)

---

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

`fuller.new()` boots React once, in about 90 ms. The `Renderer` is an immutable value, so share it across processes. `render_to_string` gives HTML a client React can hydrate, `render_to_static_markup` gives plain HTML. A 200 row table renders in about 20 ms.

For a longer example run `gleam run -m example`.

#### How it works

`js/entry.js` imports `react` and the synchronous server renderer from `react-dom`. `scripts/build.sh` bundles that with esbuild into one script and Arc's AOT compiler turns the script into `src/fuller_react_dom_server.erl`. That file is 9 MB, checked in, and compiles in about 8 seconds. `fuller.new()` runs its top level once and keeps `React.createElement`, `renderToString` and `renderToStaticMarkup`. React itself is unmodified React 19.

Gleam components with hooks and context work, the streaming renderers and client side hydration do not exist yet.

```sh
ARC_DIR=../arc scripts/build.sh
```
