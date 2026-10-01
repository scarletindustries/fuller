//// SVG elements. Function names are snake_case (`linear_gradient`); the
//// tags are SVG's own (`linearGradient`). Attributes are in
//// `fuller/attribute/svg`, plus general ones such as `attribute.id` and
//// `attribute.class` from `fuller/attribute`.
////
//// Every element takes attributes and children. Most shapes and filter
//// primitives usually get `[]` for children, but SVG lets them hold
//// `<title>` (a tooltip and accessible name) and animation elements.
////
//// ```gleam
//// import fuller/element/svg
//// import fuller/attribute/svg as svg_attribute
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
////     svg_attribute.stroke_linejoin("round"),
////   ],
////   [svg.path([svg_attribute.d("M20 6 9 17l-5-5")], [])],
//// )
//// ```

import fuller/attribute.{type Attribute}
import fuller/element.{type Element}

/// The `<animate>` element: animates one attribute of its parent over time.
/// Name the attribute with `svg_attribute.attribute_name` and set the timing
/// with `svg_attribute.dur`.
///
/// ```gleam
/// svg.circle([svg_attribute.cx("12"), svg_attribute.cy("12"), svg_attribute.r("4")], [
///   svg.animate([
///     svg_attribute.attribute_name("opacity"),
///     svg_attribute.values("1;0;1"),
///     svg_attribute.dur("2s"),
///     svg_attribute.repeat_count("indefinite"),
///   ], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/animate)
pub fn animate(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("animate", attributes, children)
}

/// The `<animateMotion>` element: moves its parent along a motion path,
/// given by a child `<mpath>` or inline with
/// `attribute.attribute("path", "M0 0 L100 0")`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/animateMotion)
pub fn animate_motion(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("animateMotion", attributes, children)
}

/// The `<animateTransform>` element: animates the `transform` of its parent,
/// such as a rotation or scale. Set the kind with `svg_attribute.type_`
/// (`"translate"`, `"scale"`, `"rotate"`, `"skewX"` or `"skewY"`).
///
/// ```gleam
/// svg.animate_transform([
///   svg_attribute.attribute_name("transform"),
///   svg_attribute.type_("rotate"),
///   svg_attribute.from("0 12 12"),
///   svg_attribute.to("360 12 12"),
///   svg_attribute.dur("1s"),
///   svg_attribute.repeat_count("indefinite"),
/// ], [])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/animateTransform)
pub fn animate_transform(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("animateTransform", attributes, children)
}

/// The `<mpath>` element: points an `<animateMotion>` at a `<path>` defined
/// elsewhere, by `svg_attribute.href("#id")`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/mpath)
pub fn mpath(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("mpath", attributes, children)
}

/// The `<set>` element: sets an attribute of its parent to a fixed value for
/// a span of time, with no interpolation. Use `svg_attribute.attribute_name`,
/// `svg_attribute.to` and `svg_attribute.begin`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/set)
pub fn set(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("set", attributes, children)
}

/// The `<circle>` element: a circle with center `svg_attribute.cx` /
/// `svg_attribute.cy` and radius `svg_attribute.r`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/circle)
pub fn circle(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("circle", attributes, children)
}

/// The `<ellipse>` element: an ellipse with center `svg_attribute.cx` /
/// `svg_attribute.cy` and radii `svg_attribute.rx` / `svg_attribute.ry`.
///
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/ellipse)
pub fn ellipse(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("ellipse", attributes, children)
}

/// The `<line>` element: a straight line from `svg_attribute.x1` /
/// `svg_attribute.y1` to `svg_attribute.x2` / `svg_attribute.y2`. A line has
/// no inside, so it needs a `stroke` to show.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/line)
pub fn line(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("line", attributes, children)
}

/// The `<polygon>` element: a closed shape through `svg_attribute.points`,
/// a list of `x,y` pairs separated by spaces (`"0,0 10,0 5,8"`).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/polygon)
pub fn polygon(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("polygon", attributes, children)
}

/// The `<polyline>` element: an open line through `svg_attribute.points`,
/// a list of `x,y` pairs separated by spaces. Unlike `polygon`, the last
/// point is not joined to the first.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/polyline)
pub fn polyline(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("polyline", attributes, children)
}

/// The `<rect>` element: a rectangle at `svg_attribute.x` / `svg_attribute.y`
/// with `svg_attribute.width` and `svg_attribute.height`. Round the corners
/// with `svg_attribute.rx` / `svg_attribute.ry`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/rect)
pub fn rect(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("rect", attributes, children)
}

/// The `<feBlend>` filter primitive: blends two inputs (`svg_attribute.in_`
/// and `svg_attribute.in2`) with a blend mode such as `"multiply"` or
/// `"screen"`, set with `svg_attribute.mode`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feBlend)
pub fn fe_blend(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feBlend", attributes, children)
}

/// The `<feColorMatrix>` filter primitive: transforms colors with a matrix,
/// or a shorthand chosen by `svg_attribute.type_` (`"matrix"`, `"saturate"`,
/// `"hueRotate"` or `"luminanceToAlpha"`) and `svg_attribute.values`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feColorMatrix)
pub fn fe_color_matrix(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feColorMatrix", attributes, children)
}

/// The `<feComposite>` filter primitive: combines two inputs with a
/// Porter-Duff `svg_attribute.operator` (`"over"`, `"in"`, `"out"`, `"atop"`,
/// `"xor"`, `"lighter"` or `"arithmetic"`).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feComposite)
pub fn fe_composite(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feComposite", attributes, children)
}

/// The `<feConvolveMatrix>` filter primitive: applies a convolution kernel,
/// for effects like sharpen, emboss or edge detection.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feConvolveMatrix)
pub fn fe_convolve_matrix(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feConvolveMatrix", attributes, children)
}

/// The `<feDropShadow>` filter primitive: draws a blurred, offset shadow of
/// its input. Set the offset with `svg_attribute.dx` / `svg_attribute.dy`
/// and the blur with `svg_attribute.std_deviation`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feDropShadow)
pub fn fe_drop_shadow(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feDropShadow", attributes, children)
}

/// The `<feFlood>` filter primitive: fills the filter region with one color,
/// set by the `flood-color` and `flood-opacity` attributes.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feFlood)
pub fn fe_flood(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feFlood", attributes, children)
}

/// The `<feFuncA>` element: the transfer function for the alpha channel,
/// inside an `fe_component_transfer`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feFuncA)
pub fn fe_func_a(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feFuncA", attributes, children)
}

/// The `<feFuncB>` element: the transfer function for the blue channel,
/// inside an `fe_component_transfer`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feFuncB)
pub fn fe_func_b(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feFuncB", attributes, children)
}

/// The `<feFuncG>` element: the transfer function for the green channel,
/// inside an `fe_component_transfer`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feFuncG)
pub fn fe_func_g(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feFuncG", attributes, children)
}

/// The `<feFuncR>` element: the transfer function for the red channel,
/// inside an `fe_component_transfer`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feFuncR)
pub fn fe_func_r(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feFuncR", attributes, children)
}

/// The `<feGaussianBlur>` filter primitive: blurs its input by
/// `svg_attribute.std_deviation` (one number, or two for x and y).
///
/// ```gleam
/// svg.filter([attribute.id("blur")], [
///   svg.fe_gaussian_blur([svg_attribute.std_deviation("4")], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feGaussianBlur)
pub fn fe_gaussian_blur(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feGaussianBlur", attributes, children)
}

/// The `<feImage>` filter primitive: loads an image, or renders an element
/// referenced by `svg_attribute.href`, as filter input. `xlink:href` is
/// deprecated; use `href`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feImage)
pub fn fe_image(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feImage", attributes, children)
}

/// The `<feMergeNode>` element: one input layer of an `fe_merge`, named by
/// `svg_attribute.in_`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feMergeNode)
pub fn fe_merge_node(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feMergeNode", attributes, children)
}

/// The `<feMorphology>` filter primitive: thickens (`"dilate"`) or thins
/// (`"erode"`) its input, chosen by `svg_attribute.operator`, by a `radius`.
///
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feMorphology)
pub fn fe_morphology(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feMorphology", attributes, children)
}

/// The `<feOffset>` filter primitive: shifts its input by `svg_attribute.dx`
/// and `svg_attribute.dy`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feOffset)
pub fn fe_offset(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feOffset", attributes, children)
}

/// The `<feTurbulence>` filter primitive: generates Perlin noise, for
/// textures like clouds or marble. `svg_attribute.type_` is `"turbulence"`
/// or `"fractalNoise"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feTurbulence)
pub fn fe_turbulence(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feTurbulence", attributes, children)
}

/// The `<stop>` element: one color stop of a `linear_gradient` or
/// `radial_gradient`, at `svg_attribute.offset` (`"0"` to `"1"`, or a
/// percentage) with `svg_attribute.stop_color`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/stop)
pub fn stop(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("stop", attributes, children)
}

/// The `<image>` element: draws a raster image or another SVG file from
/// `svg_attribute.href`, sized by `svg_attribute.width` and
/// `svg_attribute.height`. `xlink:href` is deprecated; use `href`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/image)
pub fn image(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("image", attributes, children)
}

/// The `<path>` element: a general shape drawn from the commands in
/// `svg_attribute.d`.
///
/// ```gleam
/// svg.path([
///   svg_attribute.d("M4 12h16M12 4v16"),
///   svg_attribute.stroke("currentColor"),
///   svg_attribute.stroke_width("2"),
/// ], [])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/path)
pub fn path(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("path", attributes, children)
}

/// The `<use>` element: draws a copy of another element, referenced by
/// `svg_attribute.href("#id")`, often a `symbol`. Named `use_` because `use`
/// is a Gleam keyword. `xlink:href` is deprecated; use `href`.
///
/// ```gleam
/// svg.svg([svg_attribute.view_box("0 0 24 24")], [
///   svg.use_([svg_attribute.href("#icon-check")], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/use)
pub fn use_(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("use", attributes, children)
}

/// The `<feDistantLight>` element: a light source infinitely far away, set by
/// `azimuth` and `elevation` angles. Goes inside `fe_diffuse_lighting` or
/// `fe_specular_lighting`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feDistantLight)
pub fn fe_distant_light(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feDistantLight", attributes, children)
}

/// The `<fePointLight>` element: a light source at a point (`x`, `y`, `z`)
/// that shines in all directions. Goes inside `fe_diffuse_lighting` or
/// `fe_specular_lighting`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/fePointLight)
pub fn fe_point_light(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("fePointLight", attributes, children)
}

/// The `<feSpotLight>` element: a light source at a point that shines in a
/// cone toward a target. Goes inside `fe_diffuse_lighting` or
/// `fe_specular_lighting`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feSpotLight)
pub fn fe_spot_light(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feSpotLight", attributes, children)
}

/// The SVG `<a>` element: a hyperlink around SVG content. Set the target with
/// `svg_attribute.href`; `xlink:href` is deprecated. This is not the HTML
/// `<a>`, which is `html.a`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/a)
pub fn a(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("a", attributes, children)
}

/// The `<defs>` element: holds elements to reuse later, such as gradients,
/// clip paths, filters and symbols. Nothing inside is drawn directly; refer
/// to it by `attribute.id`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/defs)
pub fn defs(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("defs", attributes, children)
}

/// The `<g>` element: groups children so they share a `transform`, `fill`,
/// `stroke` or other inherited attributes.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/g)
pub fn g(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("g", attributes, children)
}

/// The `<marker>` element: a shape, such as an arrowhead, drawn at the ends
/// or vertices of a `path`, `line`, `polyline` or `polygon`. Attach it with
/// `svg_attribute.marker_end("url(#id)")` and friends.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/marker)
pub fn marker(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("marker", attributes, children)
}

/// The `<mask>` element: a mask whose luminance sets how visible the masked
/// element is (white shows, black hides). Apply it with
/// `svg_attribute.mask("url(#id)")`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/mask)
pub fn mask(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("mask", attributes, children)
}

/// The `<pattern>` element: a tile that repeats to fill or stroke a shape.
/// Use it as a paint with `svg_attribute.fill("url(#id)")`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/pattern)
pub fn pattern(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("pattern", attributes, children)
}

/// The `<svg>` element: the root of an SVG image, or a nested viewport. Set
/// the coordinate system with `svg_attribute.view_box`. `xmlns` is only
/// needed when the markup is served as a standalone `.svg` file; inline SVG
/// in HTML works without it.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/svg)
pub fn svg(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("svg", attributes, children)
}

/// The `<switch>` element: renders only the first direct child whose
/// conditions (`systemLanguage`, `requiredExtensions`) match.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/switch)
pub fn switch(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("switch", attributes, children)
}

/// The `<symbol>` element: a reusable graphic with its own `viewBox`. It is
/// not drawn on its own; draw copies with `use_`.
///
/// ```gleam
/// svg.symbol(
///   [attribute.id("icon-check"), svg_attribute.view_box("0 0 24 24")],
///   [svg.path([svg_attribute.d("M20 6 9 17l-5-5")], [])],
/// )
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/symbol)
pub fn symbol(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("symbol", attributes, children)
}

/// The `<view>` element: a named view (a `viewBox` and aspect ratio) that a
/// URL fragment such as `image.svg#zoomed` can select.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/view)
pub fn view(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("view", attributes, children)
}

/// The `<desc>` element: a longer text description of its parent, for
/// assistive tech. It is not rendered.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/desc)
pub fn desc(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("desc", attributes, children)
}

/// The `<metadata>` element: structured metadata (usually XML such as RDF)
/// about the SVG. It is not rendered.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/metadata)
pub fn metadata(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("metadata", attributes, children)
}

/// The SVG `<title>` element: a short accessible name for its parent, often
/// shown as a tooltip. Put it first inside its parent. This is not the
/// document title, which is `html.title`; React doesn't hoist a `<title>`
/// that is inside an `<svg>`.
///
/// ```gleam
/// svg.svg([svg_attribute.view_box("0 0 24 24")], [
///   svg.title([], [html.text("Done")]),
///   svg.path([svg_attribute.d("M20 6 9 17l-5-5")], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/title)
pub fn title(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("title", attributes, children)
}

/// The `<filter>` element: a chain of `fe_*` filter primitives. Apply it to
/// an element with the `filter` attribute set to `"url(#id)"`. Each
/// primitive can name its output with `svg_attribute.result` and read
/// others with `svg_attribute.in_`.
///
/// ```gleam
/// svg.filter([attribute.id("shadow")], [
///   svg.fe_drop_shadow([
///     svg_attribute.dx("0"),
///     svg_attribute.dy("2"),
///     svg_attribute.std_deviation("2"),
///   ], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/filter)
pub fn filter(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("filter", attributes, children)
}

/// The `<feComponentTransfer>` filter primitive: remaps each color channel
/// separately. Its children are `fe_func_r`, `fe_func_g`, `fe_func_b` and
/// `fe_func_a`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feComponentTransfer)
pub fn fe_component_transfer(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feComponentTransfer", attributes, children)
}

/// The `<feDiffuseLighting>` filter primitive: lights its input's alpha
/// channel as a bump map, with a matte finish. Its child is one light
/// source: `fe_distant_light`, `fe_point_light` or `fe_spot_light`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feDiffuseLighting)
pub fn fe_diffuse_lighting(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feDiffuseLighting", attributes, children)
}

/// The `<feDisplacementMap>` filter primitive: shifts the pixels of
/// `svg_attribute.in_` using the colors of `svg_attribute.in2`, for warp and
/// ripple effects.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feDisplacementMap)
pub fn fe_displacement_map(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feDisplacementMap", attributes, children)
}

/// The `<feMerge>` filter primitive: stacks several inputs, each given by an
/// `fe_merge_node` child, with later ones on top.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feMerge)
pub fn fe_merge(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feMerge", attributes, children)
}

/// The `<feSpecularLighting>` filter primitive: lights its input's alpha
/// channel as a bump map, with shiny highlights. Its child is one light
/// source: `fe_distant_light`, `fe_point_light` or `fe_spot_light`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feSpecularLighting)
pub fn fe_specular_lighting(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feSpecularLighting", attributes, children)
}

/// The `<feTile>` filter primitive: fills the filter region with repeated
/// copies of its input.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/feTile)
pub fn fe_tile(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feTile", attributes, children)
}

/// The `<linearGradient>` element: a gradient along a line from
/// `svg_attribute.x1` / `svg_attribute.y1` to `svg_attribute.x2` /
/// `svg_attribute.y2`. Its children are `stop`s. Use it as a paint with
/// `svg_attribute.fill("url(#id)")`.
///
/// ```gleam
/// svg.svg([svg_attribute.view_box("0 0 100 10")], [
///   svg.defs([], [
///     svg.linear_gradient([attribute.id("fade")], [
///       svg.stop([svg_attribute.offset("0%"), svg_attribute.stop_color("gold")], []),
///       svg.stop([svg_attribute.offset("100%"), svg_attribute.stop_color("red")], []),
///     ]),
///   ]),
///   svg.rect([
///     svg_attribute.width("100"),
///     svg_attribute.height("10"),
///     svg_attribute.fill("url(#fade)"),
///   ], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/linearGradient)
pub fn linear_gradient(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("linearGradient", attributes, children)
}

/// The `<radialGradient>` element: a gradient out from a center
/// (`svg_attribute.cx`, `svg_attribute.cy`, `svg_attribute.r`), with an
/// optional focal point (`svg_attribute.fx`, `svg_attribute.fy`). Its
/// children are `stop`s. Use it as a paint with
/// `svg_attribute.fill("url(#id)")`.
///
/// ```gleam
/// svg.radial_gradient([attribute.id("glow")], [
///   svg.stop([svg_attribute.offset("0"), svg_attribute.stop_color("white")], []),
///   svg.stop([
///     svg_attribute.offset("1"),
///     svg_attribute.stop_color("white"),
///     svg_attribute.stop_opacity("0"),
///   ], []),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/radialGradient)
pub fn radial_gradient(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("radialGradient", attributes, children)
}

/// The `<clipPath>` element: a clipping region; only the parts of an element
/// inside its shapes are drawn. Apply it with
/// `svg_attribute.clip_path("url(#id)")`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/clipPath)
pub fn clip_path(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("clipPath", attributes, children)
}

/// The `<foreignObject>` element: a box, placed with `svg_attribute.x`,
/// `svg_attribute.y`, `svg_attribute.width` and `svg_attribute.height`, that
/// holds HTML content such as `html.div`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/foreignObject)
pub fn foreign_object(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("foreignObject", attributes, children)
}

/// The `<textPath>` element: lays text along a `<path>` referenced by
/// `svg_attribute.href("#id")`. It must be inside a `text` element.
/// `xlink:href` is deprecated; use `href`.
///
/// ```gleam
/// svg.text([], [
///   svg.text_path([svg_attribute.href("#curve")], [html.text("Along the curve")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/textPath)
pub fn text_path(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("textPath", attributes, children)
}

/// The `<tspan>` element: a run of text inside a `text` element that can
/// have its own position (`svg_attribute.x`, `svg_attribute.dy`, ...) and
/// styling.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/tspan)
pub fn tspan(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tspan", attributes, children)
}

/// The SVG `<text>` element: draws text at `svg_attribute.x` /
/// `svg_attribute.y`. This is an element, not a text node like `html.text`:
/// its children are text nodes made with `html.text`, or `tspan` and
/// `text_path` elements.
///
/// ```gleam
/// svg.text(
///   [
///     svg_attribute.x("12"),
///     svg_attribute.y("16"),
///     svg_attribute.text_anchor("middle"),
///   ],
///   [html.text("Hi")],
/// )
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/text)
pub fn text(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("text", attributes, children)
}

/// The SVG `<style>` element: CSS that applies to the document, given as a
/// text child made with `html.text`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/style)
pub fn style(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("style", attributes, children)
}

/// The SVG `<script>` element: a script, given by `svg_attribute.href` or as
/// a text child. React doesn't run a `<script>` it creates on the client;
/// only one in the server-rendered markup runs when the page loads.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/SVG/Reference/Element/script)
pub fn script(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("script", attributes, children)
}
