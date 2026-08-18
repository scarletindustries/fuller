import fuller
import fuller/attribute
import fuller/element
import fuller/element/html
import gleeunit

pub fn main() {
  gleeunit.main()
}

fn renderer() -> fuller.Renderer {
  fuller.new()
}

pub fn render_to_string_test() {
  let page =
    html.div([attribute.class("app")], [
      html.h1([], [html.text("Hello "), html.text("Gleam")]),
      html.ul(
        [],
        [1, 2, 3]
          |> list_map(fn(i) {
            html.li([], [html.text("item " <> int_to_string(i))])
          }),
      ),
    ])
  assert fuller.render_to_string(renderer(), page)
    == Ok(
      "<div class=\"app\"><h1>Hello <!-- -->Gleam</h1><ul><li>item 1</li><li>item 2</li><li>item 3</li></ul></div>",
    )
}

pub fn render_to_static_markup_test() {
  let page = html.p([], [html.text("a"), html.text("b")])
  assert fuller.render_to_static_markup(renderer(), page) == Ok("<p>ab</p>")
}

pub fn escapes_text_and_attributes_test() {
  let el = html.a([attribute.href("/?a=1&b=<2>")], [html.text("<script>")])
  assert fuller.render_to_static_markup(renderer(), el)
    == Ok("<a href=\"/?a=1&amp;b=&lt;2&gt;\">&lt;script&gt;</a>")
}

pub fn attributes_test() {
  let el =
    html.input([
      attribute.type_("checkbox"),
      attribute.checked(True),
      attribute.disabled(False),
      attribute.int("tabIndex", 3),
      attribute.data("id", "x"),
      attribute.style([#("backgroundColor", "red"), #("marginTop", "4px")]),
    ])
  assert fuller.render_to_static_markup(renderer(), el)
    == Ok(
      "<input type=\"checkbox\" tabindex=\"3\" data-id=\"x\" style=\"background-color:red;margin-top:4px\" checked=\"\"/>",
    )
}

pub fn fragment_none_and_inner_html_test() {
  let el =
    element.fragment([
      html.span([], [html.text("x")]),
      element.none(),
      html.div([attribute.dangerously_set_inner_html("<b>raw</b>")], []),
    ])
  assert fuller.render_to_static_markup(renderer(), el)
    == Ok("<span>x</span><div><b>raw</b></div>")
}

pub fn renderer_is_reusable_test() {
  let r = renderer()
  assert fuller.render_to_static_markup(r, html.p([], [html.text("1")]))
    == Ok("<p>1</p>")
  assert fuller.render_to_static_markup(r, html.p([], [html.text("2")]))
    == Ok("<p>2</p>")
}

fn list_map(xs: List(a), f: fn(a) -> b) -> List(b) {
  case xs {
    [] -> []
    [x, ..rest] -> [f(x), ..list_map(rest, f)]
  }
}

@external(erlang, "erlang", "integer_to_binary")
fn int_to_string(i: Int) -> String
