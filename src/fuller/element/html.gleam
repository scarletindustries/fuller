//// HTML elements, one function per tag, named after the tag (`html.div`
//// builds `<div>`). Each takes a list of attributes from `fuller/attribute`
//// and, unless it is a void element, a list of children. Void elements
//// (`br`, `img`, `input`, `meta` and so on) take attributes only, because
//// React throws if they are given children.
////
//// Text goes in as `html.text`. Every builder produces a plain
//// `fuller/element.Element` value, which `fuller.render_to_string` turns into
//// a React element and renders. For a tag not listed here, use
//// `element.element` from `fuller/element`; for SVG content, use
//// `fuller/element/svg`.
////
//// ```gleam
//// import fuller/attribute
//// import fuller/element/html
////
//// html.nav([attribute.aria_label("Main")], [
////   html.ul([], [
////     html.li([], [html.a([attribute.href("/")], [html.text("Home")])]),
////     html.li([], [html.a([attribute.href("/about")], [html.text("About")])]),
////   ]),
//// ])
//// ```

import fuller/attribute.{type Attribute}
import fuller/element.{type Element}

/// A text node, not an element. React escapes it when rendering, so `<` and
/// `&` show up as written.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/API/Text)
pub fn text(content: String) -> Element {
  element.text(content)
}

/// The `<html>` element: the root of a document. Set `lang` on it. Rendering
/// a full document from `<html>` lets React hoist `<title>`, `<meta>` and
/// `<link>` from anywhere in the tree into `<head>`.
///
/// ```gleam
/// html.html([attribute.lang("en")], [
///   html.head([], [
///     html.meta([attribute.charset("utf-8")]),
///     html.title([], [html.text("Home")]),
///   ]),
///   html.body([], [html.h1([], [html.text("Hello")])]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/html)
pub fn html(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("html", attributes, children)
}

/// The `<head>` element: metadata for the document, such as `<title>`,
/// `<meta>`, `<link>` and `<style>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/head)
pub fn head(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("head", attributes, children)
}

/// The `<body>` element: the content of a document.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/body)
pub fn body(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("body", attributes, children)
}

/// The `<title>` element: the document's title, shown in the browser tab.
/// Give it text children; several are joined into one string, since React
/// renders an empty title for more than one child. React hoists it into
/// `<head>` when rendering a full document, so it can sit anywhere in the
/// tree.
///
/// ```gleam
/// html.title([], [html.text("Settings | " <> site_name)])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/title)
pub fn title(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("title", attributes, children)
}

/// The `<meta>` element: document metadata, such as the character set,
/// viewport or description. A void element: attributes only. React hoists it
/// into `<head>` unless it has an `itemprop`.
///
/// ```gleam
/// html.meta([attribute.charset("utf-8")])
/// html.meta([
///   attribute.name("viewport"),
///   attribute.content("width=device-width, initial-scale=1"),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta)
pub fn meta(attributes: List(Attribute)) -> Element {
  element.element("meta", attributes, [])
}

/// The `<link>` element: a link to an external resource, most often a
/// stylesheet or icon. A void element: attributes only. React hoists a
/// `<link>` with `rel` and `href` into `<head>`.
///
/// ```gleam
/// html.link([attribute.rel("stylesheet"), attribute.href("/app.css")])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/link)
pub fn link(attributes: List(Attribute)) -> Element {
  element.element("link", attributes, [])
}

/// The `<script>` element: an external script (`src`) or inline JavaScript.
/// Pass inline code as `html.text` children (several are joined into one).
/// React writes it as is, without HTML escaping, and only rewrites
/// `</script` so it can't close the tag early.
///
/// ```gleam
/// html.script([attribute.src("/app.js"), attribute.defer(True)], [])
/// html.script([], [html.text("window.ready = a < b && c;")])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script)
pub fn script(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("script", attributes, children)
}

/// The `<style>` element: inline CSS. Pass the CSS as `html.text` children
/// (several are joined into one). React writes it without HTML escaping, so
/// `>` and quotes are safe, and only rewrites `</style` so it can't close
/// the tag early.
///
/// ```gleam
/// html.style([], [html.text("ul > li { margin: 0 }")])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/style)
pub fn style(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("style", attributes, children)
}

/// The `<noscript>` element: content shown only when scripting is disabled.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/noscript)
pub fn noscript(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("noscript", attributes, children)
}

/// The `<header>` element: introductory content for the page or its
/// nearest section, such as a logo, heading or navigation.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/header)
pub fn header(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("header", attributes, children)
}

/// The `<footer>` element: a footer for the page or its nearest section,
/// such as authorship, copyright or related links.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/footer)
pub fn footer(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("footer", attributes, children)
}

/// The `<nav>` element: a block of navigation links. Give each `<nav>` on a
/// page a distinct `aria-label`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/nav)
pub fn nav(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("nav", attributes, children)
}

/// The `<main>` element: the dominant content of the page. Use only one
/// visible `<main>` per page.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/main)
pub fn main(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("main", attributes, children)
}

/// The `<section>` element: a generic standalone section of a document,
/// usually with a heading.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/section)
pub fn section(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("section", attributes, children)
}

/// The `<article>` element: a self-contained composition, such as a blog
/// post, comment or product card.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/article)
pub fn article(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("article", attributes, children)
}

/// The `<aside>` element: content only indirectly related to the main
/// content, such as a sidebar or call-out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/aside)
pub fn aside(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("aside", attributes, children)
}

/// The `<h1>` element: a level 1 heading, the highest. Don't skip heading
/// levels.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements)
pub fn h1(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h1", attributes, children)
}

/// The `<h2>` element: a level 2 heading.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements)
pub fn h2(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h2", attributes, children)
}

/// The `<h3>` element: a level 3 heading.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements)
pub fn h3(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h3", attributes, children)
}

/// The `<h4>` element: a level 4 heading.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements)
pub fn h4(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h4", attributes, children)
}

/// The `<h5>` element: a level 5 heading.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements)
pub fn h5(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h5", attributes, children)
}

/// The `<h6>` element: a level 6 heading, the lowest.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/Heading_Elements)
pub fn h6(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("h6", attributes, children)
}

/// The `<div>` element: a generic block container with no meaning of its
/// own.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/div)
pub fn div(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("div", attributes, children)
}

/// The `<span>` element: a generic inline container with no meaning of its
/// own.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/span)
pub fn span(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("span", attributes, children)
}

/// The `<p>` element: a paragraph. Browsers close a `<p>` before any block
/// element, so don't nest a `<div>` or another `<p>` inside one.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/p)
pub fn p(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("p", attributes, children)
}

/// The `<a>` element: a hyperlink to the URL in `href`. `target("_blank")`
/// opens it in a new tab.
///
/// ```gleam
/// html.a([attribute.href("https://gleam.run"), attribute.target("_blank")], [
///   html.text("Gleam"),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a)
pub fn a(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("a", attributes, children)
}

/// The `<ul>` element: an unordered (bulleted) list of `<li>` items. Give
/// each item a `key` when the list is built from data.
///
/// ```gleam
/// html.ul([], list.map(users, fn(user) {
///   html.li([attribute.key(user.id)], [html.text(user.name)])
/// }))
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ul)
pub fn ul(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("ul", attributes, children)
}

/// The `<ol>` element: an ordered (numbered) list of `<li>` items. `start`
/// and `reversed` control the numbering.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ol)
pub fn ol(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("ol", attributes, children)
}

/// The `<li>` element: an item in a `<ul>`, `<ol>` or `<menu>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/li)
pub fn li(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("li", attributes, children)
}

/// The `<dl>` element: a description list of `<dt>` terms, each followed by
/// one or more `<dd>` descriptions.
///
/// ```gleam
/// html.dl([], [
///   html.dt([], [html.text("Runtime")]),
///   html.dd([], [html.text("BEAM")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dl)
pub fn dl(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dl", attributes, children)
}

/// The `<dt>` element: a term in a `<dl>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dt)
pub fn dt(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dt", attributes, children)
}

/// The `<dd>` element: the description of the preceding `<dt>` in a `<dl>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dd)
pub fn dd(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dd", attributes, children)
}

/// The `<blockquote>` element: an extended quotation. Put the source URL in
/// `cite`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/blockquote)
pub fn blockquote(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("blockquote", attributes, children)
}

/// The `<pre>` element: preformatted text, shown with whitespace kept as
/// written, usually in a monospace font.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/pre)
pub fn pre(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("pre", attributes, children)
}

/// The `<code>` element: a fragment of computer code. Wrap it in `<pre>` for
/// a block.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/code)
pub fn code(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("code", attributes, children)
}

/// The `<em>` element: stress emphasis, usually shown in italics.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/em)
pub fn em(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("em", attributes, children)
}

/// The `<strong>` element: strong importance, seriousness or urgency,
/// usually shown in bold.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/strong)
pub fn strong(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("strong", attributes, children)
}

/// The `<small>` element: side comments and small print, such as copyright
/// or legal text.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/small)
pub fn small(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("small", attributes, children)
}

/// The `<b>` element: text drawn to attention without extra importance,
/// such as keywords. Use `<strong>` for importance.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/b)
pub fn b(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("b", attributes, children)
}

/// The `<i>` element: text set off from the rest, such as a technical term,
/// a foreign phrase or a thought. Use `<em>` for emphasis.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/i)
pub fn i(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("i", attributes, children)
}

/// The `<u>` element: text with a non-textual annotation, such as a
/// spelling error, shown underlined.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/u)
pub fn u(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("u", attributes, children)
}

/// The `<s>` element: text that is no longer accurate or relevant, shown
/// struck through. Use `<del>` for document edits.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/s)
pub fn s(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("s", attributes, children)
}

/// The `<sub>` element: subscript text, as in chemical formulas.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sub)
pub fn sub(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("sub", attributes, children)
}

/// The `<sup>` element: superscript text, as in exponents or ordinals.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/sup)
pub fn sup(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("sup", attributes, children)
}

/// The `<br>` element: a line break in text, as in a poem or address. A void
/// element: attributes only.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/br)
pub fn br(attributes: List(Attribute)) -> Element {
  element.element("br", attributes, [])
}

/// The `<hr>` element: a thematic break between paragraphs, usually drawn as
/// a horizontal rule. A void element: attributes only.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hr)
pub fn hr(attributes: List(Attribute)) -> Element {
  element.element("hr", attributes, [])
}

/// The `<img>` element: an image. A void element: attributes only. Always set
/// `alt` (an empty string for decorative images), and set `width` and
/// `height` to avoid layout shift.
///
/// ```gleam
/// html.img([
///   attribute.src("/cat.jpg"),
///   attribute.srcset("/cat.jpg 1x, /cat@2x.jpg 2x"),
///   attribute.alt("A cat asleep on a keyboard"),
///   attribute.width(640),
///   attribute.height(480),
///   attribute.loading("lazy"),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img)
pub fn img(attributes: List(Attribute)) -> Element {
  element.element("img", attributes, [])
}

/// The `<picture>` element: zero or more `<source>` elements and one
/// `<img>`. The browser uses the first matching source, falling back to the
/// `<img>`.
///
/// ```gleam
/// html.picture([], [
///   html.source([attribute.srcset("/hero.avif"), attribute.type_("image/avif")]),
///   html.source([attribute.srcset("/hero.webp"), attribute.type_("image/webp")]),
///   html.img([attribute.src("/hero.jpg"), attribute.alt("Mountains at dawn")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/picture)
pub fn picture(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("picture", attributes, children)
}

/// The `<source>` element: one media resource for a `<picture>`, `<video>`
/// or `<audio>`. A void element: attributes only. Inside `<picture>` it uses
/// `srcset`; inside `<video>` and `<audio>` it uses `src`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/source)
pub fn source(attributes: List(Attribute)) -> Element {
  element.element("source", attributes, [])
}

/// The `<video>` element: an embedded video player. Give it a `src` or
/// `<source>` children, plus `<track>` children for captions. Any other
/// children are fallback content for browsers without video support.
///
/// ```gleam
/// html.video([attribute.controls(True), attribute.poster("/intro.jpg")], [
///   html.source([attribute.src("/intro.webm"), attribute.type_("video/webm")]),
///   html.source([attribute.src("/intro.mp4"), attribute.type_("video/mp4")]),
///   html.track([
///     attribute.kind("captions"),
///     attribute.src("/intro.en.vtt"),
///     attribute.srclang("en"),
///     attribute.label("English"),
///   ]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video)
pub fn video(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("video", attributes, children)
}

/// The `<audio>` element: embedded sound. Give it a `src` or `<source>`
/// children; without `controls` the browser shows no player.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/audio)
pub fn audio(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("audio", attributes, children)
}

/// The `<canvas>` element: a drawing surface that scripts paint on.
/// Children are fallback content. `width` and `height` default to 300 by
/// 150 pixels.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/canvas)
pub fn canvas(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("canvas", attributes, children)
}

/// The `<svg>` element: an inline SVG image. Same as `svg.svg` from
/// `fuller/element/svg`; build its children and attributes with that module
/// and `fuller/attribute/svg`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/svg)
pub fn svg(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("svg", attributes, children)
}

/// The `<iframe>` element: another page embedded in this one, from `src` or
/// inline `srcdoc`. Give it a `title` for assistive tech, and restrict it
/// with `sandbox` and `allow` when the content is untrusted.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe)
pub fn iframe(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("iframe", attributes, children)
}

/// The `<figure>` element: self-contained content, such as an image, chart
/// or code listing, with an optional `<figcaption>`.
///
/// ```gleam
/// html.figure([], [
///   html.img([attribute.src("/chart.png"), attribute.alt("Sales by month")]),
///   html.figcaption([], [html.text("Sales rose 12% in March.")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figure)
pub fn figure(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("figure", attributes, children)
}

/// The `<figcaption>` element: a caption for its parent `<figure>`, as its
/// first or last child.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/figcaption)
pub fn figcaption(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("figcaption", attributes, children)
}

/// The `<table>` element: tabular data. Put rows inside `<thead>`, `<tbody>`
/// and `<tfoot>`, not directly in the table: browsers insert a `<tbody>`
/// when parsing, which breaks React hydration.
///
/// ```gleam
/// html.table([], [
///   html.caption([], [html.text("Team")]),
///   html.thead([], [
///     html.tr([], [
///       html.th([attribute.scope("col")], [html.text("Name")]),
///       html.th([attribute.scope("col")], [html.text("Role")]),
///     ]),
///   ]),
///   html.tbody([], [
///     html.tr([], [
///       html.td([], [html.text("Ada")]),
///       html.td([], [html.text("Engineer")]),
///     ]),
///   ]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/table)
pub fn table(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("table", attributes, children)
}

/// The `<thead>` element: the header rows of a `<table>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/thead)
pub fn thead(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("thead", attributes, children)
}

/// The `<tbody>` element: the body rows of a `<table>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tbody)
pub fn tbody(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tbody", attributes, children)
}

/// The `<tfoot>` element: the footer rows of a `<table>`, such as totals.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tfoot)
pub fn tfoot(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tfoot", attributes, children)
}

/// The `<tr>` element: a row of `<th>` and `<td>` cells in a table.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/tr)
pub fn tr(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tr", attributes, children)
}

/// The `<th>` element: a header cell in a table. `scope` says whether it
/// heads a `"col"`, `"row"`, `"colgroup"` or `"rowgroup"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/th)
pub fn th(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("th", attributes, children)
}

/// The `<td>` element: a data cell in a table. `colspan` and `rowspan` make
/// it span several columns or rows.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/td)
pub fn td(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("td", attributes, children)
}

/// The `<caption>` element: the title of a `<table>`, as its first child.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/caption)
pub fn caption(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("caption", attributes, children)
}

/// The `<colgroup>` element: a group of table columns, defined by `<col>`
/// children or a `span`. It comes after any `<caption>` and before the rows.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/colgroup)
pub fn colgroup(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("colgroup", attributes, children)
}

/// The `<col>` element: one or more columns (`span`) in a `<colgroup>`,
/// mostly used to style whole columns. A void element: attributes only.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/col)
pub fn col(attributes: List(Attribute)) -> Element {
  element.element("col", attributes, [])
}

/// The `<form>` element: a set of controls that submit data to `action`
/// using `method`. React drops `on*` handlers when rendering on the server,
/// so a server-rendered form submits as plain HTML.
///
/// ```gleam
/// html.form([attribute.action("/login"), attribute.method("post")], [
///   html.label([attribute.for("email")], [html.text("Email")]),
///   html.input([
///     attribute.id("email"),
///     attribute.name("email"),
///     attribute.type_("email"),
///     attribute.autocomplete("email"),
///     attribute.required(True),
///   ]),
///   html.button([attribute.type_("submit")], [html.text("Sign in")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form)
pub fn form(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("form", attributes, children)
}

/// The `<label>` element: a caption for a form control. Point `for` at the
/// control's `id`, or put the control inside the label.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/label)
pub fn label(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("label", attributes, children)
}

/// The `<input>` element: a form control whose kind is set by `type`, such
/// as `"text"`, `"email"`, `"checkbox"` or `"date"`. A void element:
/// attributes only. Set the initial value with `default_value` or
/// `default_checked`.
///
/// ```gleam
/// html.input([
///   attribute.type_("checkbox"),
///   attribute.name("subscribe"),
///   attribute.default_checked(True),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input)
pub fn input(attributes: List(Attribute)) -> Element {
  element.element("input", attributes, [])
}

/// The `<button>` element: a clickable button. Its `type` defaults to
/// `"submit"` inside a form, so set `type_("button")` for buttons that
/// shouldn't submit.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button)
pub fn button(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("button", attributes, children)
}

/// The `<select>` element: a drop-down of `<option>` children. Choose the
/// selected option with `default_value` (or `value`) on the `<select>`;
/// React marks the matching option `selected`. Don't set `selected` on an
/// `<option>`.
///
/// ```gleam
/// html.select([attribute.name("size"), attribute.default_value("m")], [
///   html.option([attribute.value("s")], [html.text("Small")]),
///   html.option([attribute.value("m")], [html.text("Medium")]),
///   html.option([attribute.value("l")], [html.text("Large")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/select)
pub fn select(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("select", attributes, children)
}

/// The `<option>` element: an item in a `<select>`, `<optgroup>` or
/// `<datalist>`. Its text child is the label; set `value` too, or React
/// matches the `<select>` value against the text. Setting `selected` makes
/// React warn; use `default_value` on the `<select>` instead.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/option)
pub fn option(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("option", attributes, children)
}

/// The `<optgroup>` element: a labeled group of `<option>` elements in a
/// `<select>`. Set the group name with `label`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/optgroup)
pub fn optgroup(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("optgroup", attributes, children)
}

/// The `<textarea>` element: a multi-line text field. Set the initial text
/// with `default_value` and pass no children. React also takes a single
/// `html.text` child as the initial text, but prefers `default_value`; more
/// than one child, or a child with `value` or `default_value`, throws.
///
/// ```gleam
/// html.textarea(
///   [attribute.name("bio"), attribute.rows(4), attribute.default_value(bio)],
///   [],
/// )
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/textarea)
pub fn textarea(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("textarea", attributes, children)
}

/// The `<fieldset>` element: a group of related form controls, captioned by
/// a `<legend>` first child. `disabled` on it disables every control inside.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/fieldset)
pub fn fieldset(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("fieldset", attributes, children)
}

/// The `<legend>` element: the caption of its parent `<fieldset>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/legend)
pub fn legend(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("legend", attributes, children)
}

/// The `<datalist>` element: suggested `<option>` values for an `<input>`.
/// Link them by giving the datalist an `id` and the input a matching `list`.
///
/// ```gleam
/// html.input([attribute.name("browser"), attribute.list("browsers")])
/// html.datalist([attribute.id("browsers")], [
///   html.option([attribute.value("Firefox")], []),
///   html.option([attribute.value("Safari")], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/datalist)
pub fn datalist(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("datalist", attributes, children)
}

/// The `<output>` element: the result of a calculation or user action. `for`
/// lists the `id`s of the controls it depends on, separated by spaces.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/output)
pub fn output(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("output", attributes, children)
}

/// The `<progress>` element: a progress bar. Set `value` and `max` (default
/// 1); without `value` it shows as indeterminate. Children are fallback text.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/progress)
pub fn progress(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("progress", attributes, children)
}

/// The `<meter>` element: a scalar value within a known range, such as disk
/// usage. Set `value`, `min`, `max`, and optionally `low`, `high` and
/// `optimum`. Use `<progress>` for task progress.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meter)
pub fn meter(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("meter", attributes, children)
}

/// The `<details>` element: a disclosure widget whose content is shown only
/// when open. The first child should be a `<summary>`; `open` renders it
/// expanded.
///
/// ```gleam
/// html.details([], [
///   html.summary([], [html.text("Shipping")]),
///   html.p([], [html.text("Orders ship within two days.")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/details)
pub fn details(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("details", attributes, children)
}

/// The `<summary>` element: the always-visible label of a `<details>`, as
/// its first child.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/summary)
pub fn summary(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("summary", attributes, children)
}

/// The `<dialog>` element: a dialog box. It is hidden unless `open`; a
/// server-rendered dialog with `open` shows as non-modal.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dialog)
pub fn dialog(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dialog", attributes, children)
}

/// The `<menu>` element: a list of `<li>` items, like `<ul>`, meant for
/// toolbars and commands.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/menu)
pub fn menu(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("menu", attributes, children)
}

/// The `<template>` element: HTML that is parsed but not rendered, for
/// scripts to clone later.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/template)
pub fn template(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("template", attributes, children)
}

/// The `<slot>` element: a placeholder inside a web component's shadow DOM,
/// filled by light DOM children with a matching `slot` attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/slot)
pub fn slot(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("slot", attributes, children)
}

/// The `<address>` element: contact information for the nearest
/// `<article>` or the whole page. Not for arbitrary postal addresses.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/address)
pub fn address(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("address", attributes, children)
}

/// The `<time>` element: a date, time or duration. Put a machine-readable
/// form in `datetime`, such as `"2026-10-01"` or `"2026-10-01T09:30Z"`.
///
/// ```gleam
/// html.time([attribute.datetime("2026-10-01")], [html.text("1 October")])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/time)
pub fn time(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("time", attributes, children)
}

/// The `<mark>` element: text highlighted for relevance, such as search
/// matches.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/mark)
pub fn mark(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("mark", attributes, children)
}

/// The `<abbr>` element: an abbreviation or acronym. Give the full form in
/// a `title` so it shows as a tooltip and is read by assistive tech.
///
/// ```gleam
/// html.abbr([attribute.title("HyperText Markup Language")], [html.text("HTML")])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/abbr)
pub fn abbr(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("abbr", attributes, children)
}

/// The `<cite>` element: the title of a creative work, such as a book,
/// paper or film.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/cite)
pub fn cite(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("cite", attributes, children)
}

/// The `<q>` element: a short inline quotation. Browsers add the quotation
/// marks; put the source URL in `cite`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/q)
pub fn q(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("q", attributes, children)
}

/// The `<dfn>` element: the term being defined in the surrounding sentence
/// or paragraph.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/dfn)
pub fn dfn(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("dfn", attributes, children)
}

/// The `<kbd>` element: text the user enters, usually from a keyboard, such
/// as a shortcut.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/kbd)
pub fn kbd(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("kbd", attributes, children)
}

/// The `<samp>` element: sample output from a program.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/samp)
pub fn samp(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("samp", attributes, children)
}

/// The `<var>` element: the name of a variable in math or code.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/var)
pub fn var(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("var", attributes, children)
}

/// The `<wbr>` element: a point where the browser may break a line, such as
/// inside a long URL. A void element: attributes only.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/wbr)
pub fn wbr(attributes: List(Attribute)) -> Element {
  element.element("wbr", attributes, [])
}

/// The `<bdi>` element: text isolated from the surrounding text direction,
/// such as a user name that may be right-to-left.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdi)
pub fn bdi(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("bdi", attributes, children)
}

/// The `<bdo>` element: text drawn in the direction set by `dir` (`"ltr"`
/// or `"rtl"`), overriding the bidirectional algorithm.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/bdo)
pub fn bdo(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("bdo", attributes, children)
}

/// The `<ruby>` element: base text with small annotations above or beside
/// it, such as pronunciation for East Asian characters. Annotations go in
/// `<rt>`, with optional `<rp>` fallback parentheses.
///
/// ```gleam
/// html.ruby([], [
///   html.text("漢"),
///   html.rp([], [html.text("(")]),
///   html.rt([], [html.text("kan")]),
///   html.rp([], [html.text(")")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ruby)
pub fn ruby(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("ruby", attributes, children)
}

/// The `<rt>` element: the annotation text in a `<ruby>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rt)
pub fn rt(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("rt", attributes, children)
}

/// The `<rp>` element: fallback parentheses around an `<rt>`, shown only by
/// browsers without ruby support.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/rp)
pub fn rp(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("rp", attributes, children)
}

/// The `<data>` element: content with a machine-readable form in `value`,
/// such as a product code. Use `<time>` for dates and times.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/data)
pub fn data(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("data", attributes, children)
}

/// The `<area>` element: a clickable region of an image map, inside a
/// `<map>`. A void element: attributes only. Set `shape`, `coords`, `href`
/// and `alt`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/area)
pub fn area(attributes: List(Attribute)) -> Element {
  element.element("area", attributes, [])
}

/// The `<base>` element: the base URL for relative URLs in the document,
/// and the default `target`. A void element: attributes only. Only one is
/// allowed, inside `<head>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/base)
pub fn base(attributes: List(Attribute)) -> Element {
  element.element("base", attributes, [])
}

/// The `<embed>` element: external content, such as a PDF, handled by the
/// browser or a plugin. A void element: attributes only.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/embed)
pub fn embed(attributes: List(Attribute)) -> Element {
  element.element("embed", attributes, [])
}

/// The `<track>` element: timed text, such as captions or subtitles in
/// WebVTT format, for a `<video>` or `<audio>`. A void element: attributes
/// only. Set `kind`, `src`, `srclang` and `label`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/track)
pub fn track(attributes: List(Attribute)) -> Element {
  element.element("track", attributes, [])
}

/// The `<hgroup>` element: a heading together with related paragraphs, such
/// as a subtitle or tagline.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/hgroup)
pub fn hgroup(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("hgroup", attributes, children)
}

/// The `<search>` element: a container for search or filtering controls,
/// with the implicit `search` landmark role.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/search)
pub fn search(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("search", attributes, children)
}

/// The `<math>` element: the root of an inline MathML formula. fuller has no
/// MathML builders, so create its children with `element.element`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/MathML/Reference/Element/math)
pub fn math(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("math", attributes, children)
}

/// The `<del>` element: text removed from the document, usually shown
/// struck through. `cite` and `datetime` record why and when.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/del)
pub fn del(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("del", attributes, children)
}

/// The `<ins>` element: text added to the document, usually shown
/// underlined. `cite` and `datetime` record why and when.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ins)
pub fn ins(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("ins", attributes, children)
}

/// The `<map>` element: an image map of `<area>` children. Give it a `name`
/// and point an `<img>`'s `usemap` at `"#name"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/map)
pub fn map(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("map", attributes, children)
}

/// The `<object>` element: an external resource, such as a PDF or image,
/// loaded from the URL in its `data` attribute (set it with
/// `attribute.attribute("data", url)`). Children are fallback content.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/object)
pub fn object(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("object", attributes, children)
}
