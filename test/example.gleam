//// gleam run -m example

import fuller as react
import fuller/attribute
import fuller/element.{type Element}
import fuller/element/html
import gleam/io
import gleam/list

type Post {
  Post(title: String, url: String, tags: List(String))
}

fn tag(name: String) -> Element {
  html.span([attribute.class("tag")], [html.text("#" <> name)])
}

fn post(post: Post) -> Element {
  html.li([], [
    html.a([attribute.href(post.url)], [html.text(post.title)]),
    html.text(" "),
    ..list.map(post.tags, tag)
  ])
}

fn page(posts: List(Post)) -> Element {
  html.html([attribute.lang("en")], [
    html.head([], [
      html.meta([attribute.attribute("charSet", "utf-8")]),
      html.title([], [html.text("fuller")]),
    ]),
    html.body([], [
      html.h1([], [html.text("React rendered on the BEAM!")]),
      html.ul([], list.map(posts, post)),
      html.footer([attribute.style([#("color", "gray")])], [
        html.text("Rendered by react-dom/server and compiled to Erlang by Arc"),
      ]),
    ]),
  ])
}

pub fn main() {
  let renderer = react.new()
  let posts = [
    Post("Arc", "https://arc.alistair.sh", ["gleam", "javascript"]),
    Post("Gleam", "https://gleam.run", ["beam"]),
  ]
  case react.render_to_static_markup(renderer, page(posts)) {
    Ok(markup) -> io.println("<!doctype html>" <> markup)
    Error(react.ReactThrew(message)) -> io.println("render failed: " <> message)
  }
}
