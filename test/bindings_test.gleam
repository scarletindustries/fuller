import fuller
import fuller/attribute
import fuller/attribute/svg as svg_attribute
import fuller/element/html
import fuller/element/svg

fn render(el) {
  fuller.render_to_static_markup(fuller.new(), el)
}

pub fn boolean_and_camel_case_attributes_test() {
  let el =
    html.input([
      attribute.readonly(True),
      attribute.required(False),
      attribute.tabindex(2),
      attribute.maxlength(5),
      attribute.autocomplete("off"),
      attribute.spellcheck(False),
      attribute.draggable(True),
    ])
  assert render(el)
    == Ok(
      "<input readOnly=\"\" tabindex=\"2\" maxLength=\"5\" autoComplete=\"off\" spellCheck=\"false\" draggable=\"true\"/>",
    )
}

pub fn aria_attributes_test() {
  let el =
    html.div(
      [
        attribute.aria_expanded(False),
        attribute.aria_hidden(True),
        attribute.aria_level(2),
        attribute.aria_label("x"),
        attribute.role("tab"),
      ],
      [],
    )
  assert render(el)
    == Ok(
      "<div aria-expanded=\"false\" aria-hidden=\"true\" aria-level=\"2\" aria-label=\"x\" role=\"tab\"></div>",
    )
}

pub fn key_is_not_rendered_and_classes_join_test() {
  let el =
    html.ul([], [
      html.li(
        [
          attribute.key("1"),
          attribute.classes([#("a", True), #("b", False), #("c", True)]),
        ],
        [],
      ),
    ])
  assert render(el) == Ok("<ul><li class=\"a c\"></li></ul>")
}

pub fn hyphenated_html_attributes_test() {
  let el =
    html.label(
      [
        attribute.for("x"),
        attribute.accept_charset("utf-8"),
        attribute.http_equiv("refresh"),
      ],
      [],
    )
  assert render(el)
    == Ok(
      "<label for=\"x\" accept-charset=\"utf-8\" http-equiv=\"refresh\"></label>",
    )
}

pub fn list_valued_attributes_test() {
  let el =
    html.td(
      [
        attribute.colspan(2),
        attribute.rowspan(3),
        attribute.headers(["h1", "h2"]),
      ],
      [],
    )
  assert render(el)
    == Ok("<td colSpan=\"2\" rowSpan=\"3\" headers=\"h1 h2\"></td>")
}

pub fn media_booleans_test() {
  let el =
    html.video(
      [
        attribute.autoplay(True),
        attribute.muted(True),
        attribute.playsinline(True),
        attribute.controls(False),
      ],
      [],
    )
  assert render(el)
    == Ok("<video autoPlay=\"\" muted=\"\" playsInline=\"\"></video>")
}

pub fn void_elements_test() {
  let el =
    html.map([attribute.name("m")], [
      html.area([attribute.coords("0,0,1,1"), attribute.shape("rect")]),
    ])
  assert render(el)
    == Ok("<map name=\"m\"><area coords=\"0,0,1,1\" shape=\"rect\"/></map>")
}

pub fn svg_test() {
  let el =
    svg.svg([svg_attribute.view_box("0 0 10 10")], [
      svg.defs([], [
        svg.linear_gradient([attribute.id("g")], [
          svg.stop([
            svg_attribute.offset("0"),
            svg_attribute.stop_color("red"),
          ]),
        ]),
      ]),
      svg.path([
        svg_attribute.d("M0 0L10 10"),
        svg_attribute.stroke_width("2"),
        svg_attribute.fill_rule("evenodd"),
      ]),
      svg.use_([svg_attribute.xlink_href("#g")]),
      svg.text([svg_attribute.text_anchor("middle")], [html.text("hi")]),
      svg.fe_gaussian_blur([svg_attribute.std_deviation("2")]),
    ])
  assert render(el)
    == Ok(
      "<svg viewBox=\"0 0 10 10\"><defs><linearGradient id=\"g\"><stop offset=\"0\" stop-color=\"red\"></stop></linearGradient></defs><path d=\"M0 0L10 10\" stroke-width=\"2\" fill-rule=\"evenodd\"></path><use xlink:href=\"#g\"></use><text text-anchor=\"middle\">hi</text><feGaussianBlur stdDeviation=\"2\"></feGaussianBlur></svg>",
    )
}
