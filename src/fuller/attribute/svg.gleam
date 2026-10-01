//// SVG attributes, for use with the elements in `fuller/element/svg`.
////
//// Function names are snake_case (`stroke_width`); each sets React's
//// camelCase prop (`strokeWidth`), which React renders under SVG's own
//// name (`stroke-width`). Attributes that are camelCase in SVG itself
//// (`viewBox`, `stdDeviation`) render unchanged. Every value is a
//// `String`, since most SVG numbers can also be lengths or percentages.
////
//// Many of these are presentation attributes (`fill`, `stroke`,
//// `opacity`, ...): CSS can set them too, and CSS wins over the attribute.
////
//// ```gleam
//// import fuller/attribute
//// import fuller/attribute/svg as svg_attribute
//// import fuller/element/svg
////
//// svg.svg(
////   [
////     svg_attribute.xmlns("http://www.w3.org/2000/svg"),
////     svg_attribute.view_box("0 0 24 24"),
////     svg_attribute.width("24"),
////     svg_attribute.height("24"),
////     svg_attribute.fill("none"),
////     svg_attribute.stroke("currentColor"),
////     svg_attribute.stroke_width("2"),
////     svg_attribute.stroke_linecap("round"),
////     attribute.aria_hidden(True),
////   ],
////   [
////     svg.circle([
////       svg_attribute.cx("12"),
////       svg_attribute.cy("12"),
////       svg_attribute.r("10"),
////     ], []),
////     svg.path([svg_attribute.d("M12 8v4M12 16h.01")], []),
////   ],
//// )
//// ```

import fuller/attribute.{type Attribute}

/// The XML namespace of an `<svg>` element, normally
/// `"http://www.w3.org/2000/svg"`. Inline SVG in HTML works without it, but
/// a standalone `.svg` file or a data URL needs it.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/svg)
pub fn xmlns(value: String) -> Attribute {
  attribute.attribute("xmlns", value)
}

/// The user-space rectangle the SVG content is drawn in, as four numbers:
/// min-x, min-y, width and height, e.g. `view_box("0 0 24 24")`. The
/// content then scales to fit the element's `width` and `height`. Renders
/// as `viewBox`. Applies to `<svg>`, `<symbol>`, `<marker>`, `<pattern>`
/// and `<view>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/viewBox)
pub fn view_box(value: String) -> Attribute {
  attribute.attribute("viewBox", value)
}

/// The width of an element such as `<svg>`, `<rect>`, `<image>` or
/// `<pattern>`, as a number, length or percentage (`"24"`, `"2em"`,
/// `"100%"`). Takes a `String`, unlike `attribute.width`, which takes an
/// `Int` of pixels.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/width)
pub fn width(value: String) -> Attribute {
  attribute.attribute("width", value)
}

/// The height of an element such as `<svg>`, `<rect>`, `<image>` or
/// `<pattern>`, as a number, length or percentage (`"24"`, `"2em"`,
/// `"100%"`). Takes a `String`, unlike `attribute.height`, which takes an
/// `Int` of pixels.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/height)
pub fn height(value: String) -> Attribute {
  attribute.attribute("height", value)
}

/// The paint used to fill a shape or text: a color, `"none"`,
/// `"currentColor"` or a paint server reference like `"url(#gradient)"`.
/// A presentation attribute, so CSS `fill` can also set it. On animation
/// elements it instead means the end state (`"freeze"` or `"remove"`).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/fill)
pub fn fill(value: String) -> Attribute {
  attribute.attribute("fill", value)
}

/// The opacity of the fill, from `"0"` to `"1"` or a percentage. Renders
/// as `fill-opacity`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/fill-opacity)
pub fn fill_opacity(value: String) -> Attribute {
  attribute.attribute("fillOpacity", value)
}

/// How a shape's inside is decided where its outline crosses itself:
/// `"nonzero"` (the default) or `"evenodd"`. Renders as `fill-rule`; a
/// presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/fill-rule)
pub fn fill_rule(value: String) -> Attribute {
  attribute.attribute("fillRule", value)
}

/// The paint used for a shape's outline: a color, `"none"`,
/// `"currentColor"` or a paint server reference like `"url(#gradient)"`.
/// A presentation attribute, so CSS `stroke` can also set it.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke)
pub fn stroke(value: String) -> Attribute {
  attribute.attribute("stroke", value)
}

/// The width of the outline, as a number or length (`"2"`, `"0.5px"`).
/// Renders as `stroke-width`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke-width)
pub fn stroke_width(value: String) -> Attribute {
  attribute.attribute("strokeWidth", value)
}

/// The opacity of the outline, from `"0"` to `"1"` or a percentage.
/// Renders as `stroke-opacity`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke-opacity)
pub fn stroke_opacity(value: String) -> Attribute {
  attribute.attribute("strokeOpacity", value)
}

/// The shape at the ends of open lines: `"butt"` (the default), `"round"`
/// or `"square"`. Renders as `stroke-linecap`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke-linecap)
pub fn stroke_linecap(value: String) -> Attribute {
  attribute.attribute("strokeLinecap", value)
}

/// The shape of the corners where line segments meet: `"miter"` (the
/// default), `"round"` or `"bevel"`. SVG 2 adds `"miter-clip"` and
/// `"arcs"`, which few browsers support. Renders as `stroke-linejoin`; a
/// presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke-linejoin)
pub fn stroke_linejoin(value: String) -> Attribute {
  attribute.attribute("strokeLinejoin", value)
}

/// The dash pattern of the outline, as alternating dash and gap lengths
/// separated by spaces or commas, e.g. `stroke_dasharray("4 2")`; `"none"`
/// draws a solid line. Renders as `stroke-dasharray`; a presentation
/// attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke-dasharray)
pub fn stroke_dasharray(value: String) -> Attribute {
  attribute.attribute("strokeDasharray", value)
}

/// How far into the dash pattern the outline starts, as a length.
/// Animating it alongside `stroke_dasharray` gives the "line drawing"
/// effect. Renders as `stroke-dashoffset`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke-dashoffset)
pub fn stroke_dashoffset(value: String) -> Attribute {
  attribute.attribute("strokeDashoffset", value)
}

/// The limit on the ratio of miter length to stroke width before a
/// `"miter"` join is drawn as a bevel instead, as a number of at least 1
/// (default `"4"`). Renders as `stroke-miterlimit`; a presentation
/// attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stroke-miterlimit)
pub fn stroke_miterlimit(value: String) -> Attribute {
  attribute.attribute("strokeMiterlimit", value)
}

/// The opacity of the whole element and its children, from `"0"` to `"1"`
/// or a percentage. A presentation attribute, so CSS `opacity` can also
/// set it.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/opacity)
pub fn opacity(value: String) -> Attribute {
  attribute.attribute("opacity", value)
}

/// The path data of a `<path>`: a string of commands and coordinates, e.g.
/// `d("M 10 10 L 20 20 Z")`. Uppercase commands take absolute coordinates;
/// lowercase ones are relative.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/d)
pub fn d(value: String) -> Attribute {
  attribute.attribute("d", value)
}

/// The x coordinate of the center of a `<circle>` or `<ellipse>`, or of
/// the end circle of a `<radialGradient>`, as a number, length or
/// percentage.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/cx)
pub fn cx(value: String) -> Attribute {
  attribute.attribute("cx", value)
}

/// The y coordinate of the center of a `<circle>` or `<ellipse>`, or of
/// the end circle of a `<radialGradient>`, as a number, length or
/// percentage.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/cy)
pub fn cy(value: String) -> Attribute {
  attribute.attribute("cy", value)
}

/// The radius of a `<circle>`, or of the end circle of a
/// `<radialGradient>`, as a number, length or percentage.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/r)
pub fn r(value: String) -> Attribute {
  attribute.attribute("r", value)
}

/// The horizontal radius of an `<ellipse>`, or of the rounded corners of a
/// `<rect>`, as a number, length or percentage.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/rx)
pub fn rx(value: String) -> Attribute {
  attribute.attribute("rx", value)
}

/// The vertical radius of an `<ellipse>`, or of the rounded corners of a
/// `<rect>`, as a number, length or percentage.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/ry)
pub fn ry(value: String) -> Attribute {
  attribute.attribute("ry", value)
}

/// The x coordinate of an element such as `<rect>`, `<text>`, `<image>`,
/// `<use>` or a nested `<svg>`, as a number, length or percentage. On
/// `<text>` and `<tspan>` it can be a list of positions, one per character.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/x)
pub fn x(value: String) -> Attribute {
  attribute.attribute("x", value)
}

/// The y coordinate of an element such as `<rect>`, `<text>`, `<image>`,
/// `<use>` or a nested `<svg>`, as a number, length or percentage. On
/// `<text>` and `<tspan>` it can be a list of positions, one per character.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/y)
pub fn y(value: String) -> Attribute {
  attribute.attribute("y", value)
}

/// The x coordinate of the start of a `<line>`, or of the gradient vector
/// of a `<linearGradient>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/x1)
pub fn x1(value: String) -> Attribute {
  attribute.attribute("x1", value)
}

/// The x coordinate of the end of a `<line>`, or of the gradient vector of
/// a `<linearGradient>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/x2)
pub fn x2(value: String) -> Attribute {
  attribute.attribute("x2", value)
}

/// The y coordinate of the start of a `<line>`, or of the gradient vector
/// of a `<linearGradient>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/y1)
pub fn y1(value: String) -> Attribute {
  attribute.attribute("y1", value)
}

/// The y coordinate of the end of a `<line>`, or of the gradient vector of
/// a `<linearGradient>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/y2)
pub fn y2(value: String) -> Attribute {
  attribute.attribute("y2", value)
}

/// A horizontal shift of `<text>` or `<tspan>` content, or the x offset of
/// `<feOffset>` or `<feDropShadow>`. On text it can be a list, one shift
/// per character.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/dx)
pub fn dx(value: String) -> Attribute {
  attribute.attribute("dx", value)
}

/// A vertical shift of `<text>` or `<tspan>` content, or the y offset of
/// `<feOffset>` or `<feDropShadow>`. On text it can be a list, one shift
/// per character.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/dy)
pub fn dy(value: String) -> Attribute {
  attribute.attribute("dy", value)
}

/// The vertices of a `<polygon>` or `<polyline>`, as x,y pairs separated
/// by spaces, e.g. `points("0,0 10,0 10,10")`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/points)
pub fn points(value: String) -> Attribute {
  attribute.attribute("points", value)
}

/// A list of transforms applied to the element and its children, e.g.
/// `transform("translate(10 20) rotate(45)")`. The functions are `matrix`,
/// `translate`, `scale`, `rotate`, `skewX` and `skewY`, applied right to
/// left.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/transform)
pub fn transform(value: String) -> Attribute {
  attribute.attribute("transform", value)
}

/// The author's total length for a path, in user units. Distances along
/// the path, such as `stroke_dasharray`, are scaled to it, so `"1"` makes
/// dashes work in fractions of the path. Renders as `pathLength`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/pathLength)
pub fn path_length(value: String) -> Attribute {
  attribute.attribute("pathLength", value)
}

/// How content with a `view_box` fits an element of a different aspect
/// ratio: an alignment such as `"xMidYMid"` (the default), or `"none"` to
/// stretch, optionally followed by `"meet"` (fit inside, the default) or
/// `"slice"` (cover). Renders as `preserveAspectRatio`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/preserveAspectRatio)
pub fn preserve_aspect_ratio(value: String) -> Attribute {
  attribute.attribute("preserveAspectRatio", value)
}

/// Where a gradient `<stop>` sits along the gradient, from `"0"` to `"1"`
/// or `"0%"` to `"100%"`.
///
/// ```gleam
/// svg.linear_gradient([attribute.id("fade")], [
///   svg.stop([
///     svg_attribute.offset("0%"),
///     svg_attribute.stop_color("white"),
///   ], []),
///   svg.stop([
///     svg_attribute.offset("100%"),
///     svg_attribute.stop_color("black"),
///   ], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/stop)
pub fn offset(value: String) -> Attribute {
  attribute.attribute("offset", value)
}

/// The color of a gradient `<stop>`. Renders as `stop-color`; a
/// presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stop-color)
pub fn stop_color(value: String) -> Attribute {
  attribute.attribute("stopColor", value)
}

/// The opacity of a gradient `<stop>`, from `"0"` to `"1"` or a
/// percentage. Renders as `stop-opacity`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stop-opacity)
pub fn stop_opacity(value: String) -> Attribute {
  attribute.attribute("stopOpacity", value)
}

/// The coordinate system of a gradient's position attributes:
/// `"objectBoundingBox"` (the default; fractions of the shape's bounding
/// box) or `"userSpaceOnUse"`. Renders as `gradientUnits`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/gradientUnits)
pub fn gradient_units(value: String) -> Attribute {
  attribute.attribute("gradientUnits", value)
}

/// Extra transforms applied to a gradient, in the same syntax as
/// `transform`, e.g. `"rotate(90)"`. Renders as `gradientTransform`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/gradientTransform)
pub fn gradient_transform(value: String) -> Attribute {
  attribute.attribute("gradientTransform", value)
}

/// How a gradient fills the area beyond its ends: `"pad"` (the default),
/// `"reflect"` or `"repeat"`. Renders as `spreadMethod`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/spreadMethod)
pub fn spread_method(value: String) -> Attribute {
  attribute.attribute("spreadMethod", value)
}

/// The x coordinate of the focal point of a `<radialGradient>`, where the
/// gradient starts. Defaults to `cx`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/fx)
pub fn fx(value: String) -> Attribute {
  attribute.attribute("fx", value)
}

/// The y coordinate of the focal point of a `<radialGradient>`, where the
/// gradient starts. Defaults to `cy`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/fy)
pub fn fy(value: String) -> Attribute {
  attribute.attribute("fy", value)
}

/// Clips the element to a shape: a reference to a `<clipPath>` such as
/// `"url(#clip)"`, a CSS basic shape, or `"none"`. Renders as
/// `clip-path`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/clip-path)
pub fn clip_path(value: String) -> Attribute {
  attribute.attribute("clipPath", value)
}

/// The fill rule for shapes inside a `<clipPath>`: `"nonzero"` (the
/// default) or `"evenodd"`. Renders as `clip-rule`; a presentation
/// attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/clip-rule)
pub fn clip_rule(value: String) -> Attribute {
  attribute.attribute("clipRule", value)
}

/// The coordinate system of a `<clipPath>`'s contents: `"userSpaceOnUse"`
/// (the default) or `"objectBoundingBox"`. Renders as `clipPathUnits`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/clipPathUnits)
pub fn clip_path_units(value: String) -> Attribute {
  attribute.attribute("clipPathUnits", value)
}

/// Masks the element with a `<mask>`, referenced as `"url(#mask)"`, or
/// `"none"`. A presentation attribute, so CSS `mask` can also set it.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/mask)
pub fn mask(value: String) -> Attribute {
  attribute.attribute("mask", value)
}

/// The coordinate system of a `<mask>`'s `x`, `y`, `width` and `height`:
/// `"objectBoundingBox"` (the default) or `"userSpaceOnUse"`. Renders as
/// `maskUnits`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/maskUnits)
pub fn mask_units(value: String) -> Attribute {
  attribute.attribute("maskUnits", value)
}

/// The `<marker>` drawn at the first vertex of a path, line, polyline or
/// polygon, referenced as `"url(#arrow)"`. Renders as `marker-start`; a
/// presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/marker-start)
pub fn marker_start(value: String) -> Attribute {
  attribute.attribute("markerStart", value)
}

/// The `<marker>` drawn at every vertex except the first and last,
/// referenced as `"url(#dot)"`. Renders as `marker-mid`; a presentation
/// attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/marker-mid)
pub fn marker_mid(value: String) -> Attribute {
  attribute.attribute("markerMid", value)
}

/// The `<marker>` drawn at the last vertex of a path, line, polyline or
/// polygon, referenced as `"url(#arrow)"`. Renders as `marker-end`; a
/// presentation attribute.
///
/// ```gleam
/// svg.line([
///   svg_attribute.x1("0"),
///   svg_attribute.y1("0"),
///   svg_attribute.x2("50"),
///   svg_attribute.y2("0"),
///   svg_attribute.stroke("black"),
///   svg_attribute.marker_end("url(#arrow)"),
/// ], [])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/marker-end)
pub fn marker_end(value: String) -> Attribute {
  attribute.attribute("markerEnd", value)
}

/// The width of a `<marker>`'s viewport (default `"3"`). Renders as
/// `markerWidth`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/markerWidth)
pub fn marker_width(value: String) -> Attribute {
  attribute.attribute("markerWidth", value)
}

/// The height of a `<marker>`'s viewport (default `"3"`). Renders as
/// `markerHeight`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/markerHeight)
pub fn marker_height(value: String) -> Attribute {
  attribute.attribute("markerHeight", value)
}

/// The x coordinate of the reference point of a `<marker>` or `<symbol>`:
/// the point placed exactly on the vertex, or at the `<use>` position.
/// Renders as `refX`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/refX)
pub fn ref_x(value: String) -> Attribute {
  attribute.attribute("refX", value)
}

/// The y coordinate of the reference point of a `<marker>` or `<symbol>`:
/// the point placed exactly on the vertex, or at the `<use>` position.
/// Renders as `refY`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/refY)
pub fn ref_y(value: String) -> Attribute {
  attribute.attribute("refY", value)
}

/// How a `<marker>` is rotated: an angle such as `"45"`, `"auto"` (follow
/// the path direction) or `"auto-start-reverse"` (the same, but flipped at
/// the start, handy for double-headed arrows).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/orient)
pub fn orient(value: String) -> Attribute {
  attribute.attribute("orient", value)
}

/// The font family of text, as a CSS font-family list, e.g.
/// `"Georgia, serif"`. Renders as `font-family`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/font-family)
pub fn font_family(value: String) -> Attribute {
  attribute.attribute("fontFamily", value)
}

/// The font size of text, as a number in user units or a CSS length.
/// Renders as `font-size`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/font-size)
pub fn font_size(value: String) -> Attribute {
  attribute.attribute("fontSize", value)
}

/// The font weight of text: `"normal"`, `"bold"`, `"bolder"`, `"lighter"`
/// or a number from 1 to 1000. Renders as `font-weight`; a presentation
/// attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/font-weight)
pub fn font_weight(value: String) -> Attribute {
  attribute.attribute("fontWeight", value)
}

/// The font style of text: `"normal"`, `"italic"` or `"oblique"`. Renders
/// as `font-style`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/font-style)
pub fn font_style(value: String) -> Attribute {
  attribute.attribute("fontStyle", value)
}

/// How text is aligned to its `x` position: `"start"` (the default),
/// `"middle"` or `"end"`. Renders as `text-anchor`; a presentation
/// attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/text-anchor)
pub fn text_anchor(value: String) -> Attribute {
  attribute.attribute("textAnchor", value)
}

/// Which baseline of the text sits on its `y` position, e.g. `"auto"`,
/// `"middle"`, `"central"` or `"hanging"`. `"central"` is the usual choice
/// for vertically centered labels. Renders as `dominant-baseline`; a
/// presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/dominant-baseline)
pub fn dominant_baseline(value: String) -> Attribute {
  attribute.attribute("dominantBaseline", value)
}

/// Extra space between the characters of text, as a length or `"normal"`.
/// Renders as `letter-spacing`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/letter-spacing)
pub fn letter_spacing(value: String) -> Attribute {
  attribute.attribute("letterSpacing", value)
}

/// A URL or fragment reference: `"#icon"` on `<use>`, an image URL on
/// `<image>`, a link target on SVG `<a>`, or a gradient or pattern to
/// inherit from. Replaces the deprecated `xlink_href`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/href)
pub fn href(value: String) -> Attribute {
  attribute.attribute("href", value)
}

/// A URL or fragment reference in the XLink namespace. Deprecated in SVG 2:
/// use `href` unless you must support very old browsers. Renders as
/// `xlink:href`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/xlink:href)
pub fn xlink_href(value: String) -> Attribute {
  attribute.attribute("xlinkHref", value)
}

/// A special rendering effect: `"non-scaling-stroke"` keeps the stroke
/// width the same however the element is scaled; `"none"` is the default.
/// Renders as `vector-effect`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/vector-effect)
pub fn vector_effect(value: String) -> Attribute {
  attribute.attribute("vectorEffect", value)
}

/// The value of `currentColor` for the element and its children, so `fill`
/// and `stroke` set to `"currentColor"` pick it up. A presentation
/// attribute, so CSS `color` can also set it.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/color)
pub fn color(value: String) -> Attribute {
  attribute.attribute("color", value)
}

/// Whether the element is drawn: `"visible"` (the default), `"hidden"` or
/// `"collapse"`. Unlike `display: none`, a child of a hidden element can
/// set `"visible"` to show itself again. A presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/visibility)
pub fn visibility(value: String) -> Attribute {
  attribute.attribute("visibility", value)
}

/// The coordinate system of a `<pattern>`'s `x`, `y`, `width` and
/// `height`: `"objectBoundingBox"` (the default) or `"userSpaceOnUse"`.
/// Renders as `patternUnits`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/patternUnits)
pub fn pattern_units(value: String) -> Attribute {
  attribute.attribute("patternUnits", value)
}

/// Extra transforms applied to a `<pattern>`, in the same syntax as
/// `transform`. Renders as `patternTransform`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/patternTransform)
pub fn pattern_transform(value: String) -> Attribute {
  attribute.attribute("patternTransform", value)
}

/// The coordinate system of a `<filter>`'s `x`, `y`, `width` and `height`:
/// `"objectBoundingBox"` (the default) or `"userSpaceOnUse"`. Renders as
/// `filterUnits`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/filterUnits)
pub fn filter_units(value: String) -> Attribute {
  attribute.attribute("filterUnits", value)
}

/// The blur amount of `<feGaussianBlur>` or `<feDropShadow>`: one number,
/// or two (x then y) separated by a space. Renders as `stdDeviation`.
///
/// ```gleam
/// svg.filter([attribute.id("blur")], [
///   svg.fe_gaussian_blur([
///     svg_attribute.in_("SourceGraphic"),
///     svg_attribute.std_deviation("4"),
///   ], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/stdDeviation)
pub fn std_deviation(value: String) -> Attribute {
  attribute.attribute("stdDeviation", value)
}

/// The input of a filter primitive: a keyword such as `"SourceGraphic"` or
/// `"SourceAlpha"`, or the `result` name of an earlier primitive. Defaults
/// to the previous primitive's output. Renders as `in`; the trailing
/// underscore is there because `in` is a Gleam keyword.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/in)
pub fn in_(value: String) -> Attribute {
  attribute.attribute("in", value)
}

/// The second input of a two-input filter primitive such as `<feBlend>`,
/// `<feComposite>` or `<feDisplacementMap>`, in the same form as `in_`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/in2)
pub fn in2(value: String) -> Attribute {
  attribute.attribute("in2", value)
}

/// A name for a filter primitive's output, so later primitives can use it
/// as their `in_` or `in2`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/result)
pub fn result(value: String) -> Attribute {
  attribute.attribute("result", value)
}

/// The blend mode of `<feBlend>`, e.g. `"normal"` (the default),
/// `"multiply"`, `"screen"`, `"darken"` or `"lighten"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/mode)
pub fn mode(value: String) -> Attribute {
  attribute.attribute("mode", value)
}

/// The operation of `<feComposite>` (`"over"`, `"in"`, `"out"`, `"atop"`,
/// `"xor"` or `"arithmetic"`) or `<feMorphology>` (`"erode"` or
/// `"dilate"`).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/operator)
pub fn operator(value: String) -> Attribute {
  attribute.attribute("operator", value)
}

/// A list of values: the keyframes of an animation, separated by
/// semicolons (`"0;1;0"`), or the numbers of an `<feColorMatrix>` (20
/// numbers for `"matrix"`, one for `"saturate"` or `"hueRotate"`).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/values)
pub fn values(value: String) -> Attribute {
  attribute.attribute("values", value)
}

/// The kind of operation, which depends on the element: `"translate"`,
/// `"scale"`, `"rotate"`, `"skewX"` or `"skewY"` on `<animateTransform>`;
/// `"matrix"`, `"saturate"`, `"hueRotate"` or `"luminanceToAlpha"` on
/// `<feColorMatrix>`; the transfer function on `<feFuncR>` and friends.
/// Renders as `type`; the trailing underscore is there because `type` is
/// a Gleam keyword.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/type)
pub fn type_(value: String) -> Attribute {
  attribute.attribute("type", value)
}

/// When an animation starts: a clock value such as `"2s"`, an event such
/// as `"click"`, a sync base such as `"other.end"`, or several of these
/// separated by semicolons. Defaults to `"0s"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/begin)
pub fn begin(value: String) -> Attribute {
  attribute.attribute("begin", value)
}

/// How long one cycle of an animation lasts, as a clock value such as
/// `"2s"` or `"500ms"`, or `"indefinite"`.
///
/// ```gleam
/// svg.animate([
///   svg_attribute.attribute_name("opacity"),
///   svg_attribute.values("1;0;1"),
///   svg_attribute.dur("2s"),
///   svg_attribute.repeat_count("indefinite"),
/// ], [])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/dur)
pub fn dur(value: String) -> Attribute {
  attribute.attribute("dur", value)
}

/// How many times an animation repeats: a number (fractions allowed) or
/// `"indefinite"`. Renders as `repeatCount`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/repeatCount)
pub fn repeat_count(value: String) -> Attribute {
  attribute.attribute("repeatCount", value)
}

/// The name of the attribute an animation element changes on its target,
/// e.g. `"opacity"` or `"cx"`. Renders as `attributeName`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/attributeName)
pub fn attribute_name(value: String) -> Attribute {
  attribute.attribute("attributeName", value)
}

/// The starting value of an animation. Ignored when `values` is set.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/from)
pub fn from(value: String) -> Attribute {
  attribute.attribute("from", value)
}

/// The ending value of an animation, or the value a `<set>` applies.
/// Ignored when `values` is set.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/to)
pub fn to(value: String) -> Attribute {
  attribute.attribute("to", value)
}

/// When each of an animation's `values` is reached, as fractions of the
/// duration from `0` to `1` separated by semicolons, e.g. `"0;0.25;1"`.
/// Needs one entry per value. Renders as `keyTimes`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/keyTimes)
pub fn key_times(value: String) -> Attribute {
  attribute.attribute("keyTimes", value)
}

/// How an animation interpolates between values: `"discrete"`,
/// `"linear"` (the default for most elements), `"paced"` or `"spline"`.
/// Renders as `calcMode`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/calcMode)
pub fn calc_mode(value: String) -> Attribute {
  attribute.attribute("calcMode", value)
}

/// A hint for drawing shapes: `"auto"`, `"optimizeSpeed"`, `"crispEdges"`
/// (no anti-aliasing, for sharp lines) or `"geometricPrecision"`. Renders
/// as `shape-rendering`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/shape-rendering)
pub fn shape_rendering(value: String) -> Attribute {
  attribute.attribute("shapeRendering", value)
}

/// The length that `<text>`, `<tspan>` or `<textPath>` content is
/// stretched or squeezed to, in user units; `length_adjust` says how.
/// Renders as `textLength`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/textLength)
pub fn text_length(value: String) -> Attribute {
  attribute.attribute("textLength", value)
}

/// How text is fitted to its `text_length`: `"spacing"` (the default;
/// adjust the gaps) or `"spacingAndGlyphs"` (also stretch the glyphs).
/// Renders as `lengthAdjust`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/lengthAdjust)
pub fn length_adjust(value: String) -> Attribute {
  attribute.attribute("lengthAdjust", value)
}

/// Which parts of the element respond to the pointer, e.g.
/// `"visiblePainted"` (the default), `"fill"`, `"stroke"`, `"all"` or
/// `"none"`. Renders as `pointer-events`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/pointer-events)
pub fn pointer_events(value: String) -> Attribute {
  attribute.attribute("pointerEvents", value)
}

/// The order fill, stroke and markers are painted in. `"normal"` is fill,
/// stroke, markers; `"stroke"` draws the stroke under the fill, which suits
/// outlined text. Renders as `paint-order`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/paint-order)
pub fn paint_order(value: String) -> Attribute {
  attribute.attribute("paintOrder", value)
}

/// The origin of the element's `transform`, as in CSS `transform-origin`,
/// e.g. `"center"` or `"50% 50%"`. Defaults to `"0 0"` for most SVG
/// elements. Renders as `transform-origin`; a presentation attribute.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/transform-origin)
pub fn transform_origin(value: String) -> Attribute {
  attribute.attribute("transformOrigin", value)
}

/// Applies a filter, usually `url(#id)` pointing at a `<filter>` element. Renders as `filter`. A presentation attribute, so CSS `filter` can set it too.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/filter)
pub fn filter(value: String) -> Attribute {
  attribute.attribute("filter", value)
}

/// The fill color of an `<feFlood>` or `<feDropShadow>` result, as any CSS color. Renders as `flood-color`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/flood-color)
pub fn flood_color(value: String) -> Attribute {
  attribute.attribute("floodColor", value)
}

/// The opacity of `flood_color`, from `"0"` to `"1"` or a percentage. Renders as `flood-opacity`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/flood-opacity)
pub fn flood_opacity(value: String) -> Attribute {
  attribute.attribute("floodOpacity", value)
}

/// The light color for `<feDiffuseLighting>` and `<feSpecularLighting>`, as any CSS color. Renders as `lighting-color`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/lighting-color)
pub fn lighting_color(value: String) -> Attribute {
  attribute.attribute("lightingColor", value)
}

/// The radius of an `<feMorphology>` erode or dilate, as one number or an x and y pair (`"2"`, `"2 1"`). Renders as `radius`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/radius)
pub fn radius(value: String) -> Attribute {
  attribute.attribute("radius", value)
}

/// The direction of an `<feDistantLight>` in degrees, clockwise from the x axis in the xy plane. Renders as `azimuth`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/azimuth)
pub fn azimuth(value: String) -> Attribute {
  attribute.attribute("azimuth", value)
}

/// The angle of an `<feDistantLight>` above the xy plane, in degrees. Renders as `elevation`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/elevation)
pub fn elevation(value: String) -> Attribute {
  attribute.attribute("elevation", value)
}

/// The z position of an `<fePointLight>` or `<feSpotLight>`, in the filter's coordinate system. Renders as `z`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/z)
pub fn z(value: String) -> Attribute {
  attribute.attribute("z", value)
}

/// How far `<feDisplacementMap>` displaces pixels, as a number. Renders as `scale`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/scale)
pub fn scale(value: String) -> Attribute {
  attribute.attribute("scale", value)
}

/// The base noise frequency of `<feTurbulence>`, as one number or an x and y pair (`"0.05"`, `"0.05 0.1"`). Renders as `baseFrequency`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/baseFrequency)
pub fn base_frequency(value: String) -> Attribute {
  attribute.attribute("baseFrequency", value)
}

/// How many noise octaves `<feTurbulence>` adds up; more is finer and slower. Renders as `numOctaves`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/numOctaves)
pub fn num_octaves(value: String) -> Attribute {
  attribute.attribute("numOctaves", value)
}

/// The random seed for `<feTurbulence>`, so the noise is the same every time. Renders as `seed`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/seed)
pub fn seed(value: String) -> Attribute {
  attribute.attribute("seed", value)
}
