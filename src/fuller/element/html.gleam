import fuller/attribute.{type Attribute}
import fuller/element.{type Element}

pub fn text(content: String) -> Element {
  element.text(content)
}

pub fn html(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("html", attributes, children)
}

pub fn head(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("head", attributes, children)
}

pub fn body(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("body", attributes, children)
}

pub fn title(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("title", attributes, children)
}

pub fn meta(attributes: List(Attribute)) -> Element {
  element.element("meta", attributes, [])
}

pub fn link(attributes: List(Attribute)) -> Element {
  element.element("link", attributes, [])
}

pub fn script(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("script", attributes, children)
}

pub fn style(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("style", attributes, children)
}

pub fn noscript(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("noscript", attributes, children)
}

pub fn header(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("header", attributes, children)
}

pub fn footer(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("footer", attributes, children)
}

pub fn nav(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("nav", attributes, children)
}

pub fn main(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("main", attributes, children)
}

pub fn section(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("section", attributes, children)
}

pub fn article(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("article", attributes, children)
}

pub fn aside(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("aside", attributes, children)
}

pub fn h1(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h1", attributes, children)
}

pub fn h2(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h2", attributes, children)
}

pub fn h3(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h3", attributes, children)
}

pub fn h4(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h4", attributes, children)
}

pub fn h5(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h5", attributes, children)
}

pub fn h6(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h6", attributes, children)
}

pub fn div(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("div", attributes, children)
}

pub fn span(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("span", attributes, children)
}

pub fn p(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("p", attributes, children)
}

pub fn a(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("a", attributes, children)
}

pub fn ul(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("ul", attributes, children)
}

pub fn ol(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("ol", attributes, children)
}

pub fn li(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("li", attributes, children)
}

pub fn dl(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dl", attributes, children)
}

pub fn dt(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dt", attributes, children)
}

pub fn dd(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dd", attributes, children)
}

pub fn blockquote(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("blockquote", attributes, children)
}

pub fn pre(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("pre", attributes, children)
}

pub fn code(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("code", attributes, children)
}

pub fn em(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("em", attributes, children)
}

pub fn strong(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("strong", attributes, children)
}

pub fn small(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("small", attributes, children)
}

pub fn b(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("b", attributes, children)
}

pub fn i(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("i", attributes, children)
}

pub fn u(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("u", attributes, children)
}

pub fn s(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("s", attributes, children)
}

pub fn sub(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("sub", attributes, children)
}

pub fn sup(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("sup", attributes, children)
}

pub fn br(attributes: List(Attribute)) -> Element {
  element.element("br", attributes, [])
}

pub fn hr(attributes: List(Attribute)) -> Element {
  element.element("hr", attributes, [])
}

pub fn img(attributes: List(Attribute)) -> Element {
  element.element("img", attributes, [])
}

pub fn picture(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("picture", attributes, children)
}

pub fn source(attributes: List(Attribute)) -> Element {
  element.element("source", attributes, [])
}

pub fn video(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("video", attributes, children)
}

pub fn audio(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("audio", attributes, children)
}

pub fn canvas(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("canvas", attributes, children)
}

pub fn svg(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("svg", attributes, children)
}

pub fn iframe(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("iframe", attributes, children)
}

pub fn figure(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("figure", attributes, children)
}

pub fn figcaption(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("figcaption", attributes, children)
}

pub fn table(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("table", attributes, children)
}

pub fn thead(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("thead", attributes, children)
}

pub fn tbody(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tbody", attributes, children)
}

pub fn tfoot(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tfoot", attributes, children)
}

pub fn tr(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tr", attributes, children)
}

pub fn th(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("th", attributes, children)
}

pub fn td(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("td", attributes, children)
}

pub fn caption(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("caption", attributes, children)
}

pub fn colgroup(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("colgroup", attributes, children)
}

pub fn col(attributes: List(Attribute)) -> Element {
  element.element("col", attributes, [])
}

pub fn form(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("form", attributes, children)
}

pub fn label(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("label", attributes, children)
}

pub fn input(attributes: List(Attribute)) -> Element {
  element.element("input", attributes, [])
}

pub fn button(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("button", attributes, children)
}

pub fn select(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("select", attributes, children)
}

pub fn option(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("option", attributes, children)
}

pub fn optgroup(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("optgroup", attributes, children)
}

pub fn textarea(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("textarea", attributes, children)
}

pub fn fieldset(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("fieldset", attributes, children)
}

pub fn legend(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("legend", attributes, children)
}

pub fn datalist(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("datalist", attributes, children)
}

pub fn output(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("output", attributes, children)
}

pub fn progress(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("progress", attributes, children)
}

pub fn meter(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("meter", attributes, children)
}

pub fn details(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("details", attributes, children)
}

pub fn summary(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("summary", attributes, children)
}

pub fn dialog(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dialog", attributes, children)
}

pub fn menu(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("menu", attributes, children)
}

pub fn template(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("template", attributes, children)
}

pub fn slot(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("slot", attributes, children)
}

pub fn address(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("address", attributes, children)
}

pub fn time(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("time", attributes, children)
}

pub fn mark(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("mark", attributes, children)
}

pub fn abbr(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("abbr", attributes, children)
}

pub fn cite(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("cite", attributes, children)
}

pub fn q(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("q", attributes, children)
}

pub fn dfn(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dfn", attributes, children)
}

pub fn kbd(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("kbd", attributes, children)
}

pub fn samp(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("samp", attributes, children)
}

pub fn var(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("var", attributes, children)
}

pub fn wbr(attributes: List(Attribute)) -> Element {
  element.element("wbr", attributes, [])
}

pub fn bdi(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("bdi", attributes, children)
}

pub fn bdo(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("bdo", attributes, children)
}

pub fn ruby(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("ruby", attributes, children)
}

pub fn rt(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("rt", attributes, children)
}

pub fn rp(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("rp", attributes, children)
}

pub fn data(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("data", attributes, children)
}
