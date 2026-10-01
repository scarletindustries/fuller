//// SVG elements. Function names are snake_case (`linear_gradient`); the
//// tags are SVG's own (`linearGradient`). Attributes are in
//// `fuller/attribute/svg`.

import fuller/attribute.{type Attribute}
import fuller/element.{type Element}

pub fn animate(attributes: List(Attribute)) -> Element {
  element.element("animate", attributes, [])
}

pub fn animate_motion(attributes: List(Attribute)) -> Element {
  element.element("animateMotion", attributes, [])
}

pub fn animate_transform(attributes: List(Attribute)) -> Element {
  element.element("animateTransform", attributes, [])
}

pub fn mpath(attributes: List(Attribute)) -> Element {
  element.element("mpath", attributes, [])
}

pub fn set(attributes: List(Attribute)) -> Element {
  element.element("set", attributes, [])
}

pub fn circle(attributes: List(Attribute)) -> Element {
  element.element("circle", attributes, [])
}

pub fn ellipse(attributes: List(Attribute)) -> Element {
  element.element("ellipse", attributes, [])
}

pub fn line(attributes: List(Attribute)) -> Element {
  element.element("line", attributes, [])
}

pub fn polygon(attributes: List(Attribute)) -> Element {
  element.element("polygon", attributes, [])
}

pub fn polyline(attributes: List(Attribute)) -> Element {
  element.element("polyline", attributes, [])
}

pub fn rect(attributes: List(Attribute)) -> Element {
  element.element("rect", attributes, [])
}

pub fn fe_blend(attributes: List(Attribute)) -> Element {
  element.element("feBlend", attributes, [])
}

pub fn fe_color_matrix(attributes: List(Attribute)) -> Element {
  element.element("feColorMatrix", attributes, [])
}

pub fn fe_composite(attributes: List(Attribute)) -> Element {
  element.element("feComposite", attributes, [])
}

pub fn fe_convolve_matrix(attributes: List(Attribute)) -> Element {
  element.element("feConvolveMatrix", attributes, [])
}

pub fn fe_drop_shadow(attributes: List(Attribute)) -> Element {
  element.element("feDropShadow", attributes, [])
}

pub fn fe_flood(attributes: List(Attribute)) -> Element {
  element.element("feFlood", attributes, [])
}

pub fn fe_func_a(attributes: List(Attribute)) -> Element {
  element.element("feFuncA", attributes, [])
}

pub fn fe_func_b(attributes: List(Attribute)) -> Element {
  element.element("feFuncB", attributes, [])
}

pub fn fe_func_g(attributes: List(Attribute)) -> Element {
  element.element("feFuncG", attributes, [])
}

pub fn fe_func_r(attributes: List(Attribute)) -> Element {
  element.element("feFuncR", attributes, [])
}

pub fn fe_gaussian_blur(attributes: List(Attribute)) -> Element {
  element.element("feGaussianBlur", attributes, [])
}

pub fn fe_image(attributes: List(Attribute)) -> Element {
  element.element("feImage", attributes, [])
}

pub fn fe_merge_node(attributes: List(Attribute)) -> Element {
  element.element("feMergeNode", attributes, [])
}

pub fn fe_morphology(attributes: List(Attribute)) -> Element {
  element.element("feMorphology", attributes, [])
}

pub fn fe_offset(attributes: List(Attribute)) -> Element {
  element.element("feOffset", attributes, [])
}

pub fn fe_turbulence(attributes: List(Attribute)) -> Element {
  element.element("feTurbulence", attributes, [])
}

pub fn stop(attributes: List(Attribute)) -> Element {
  element.element("stop", attributes, [])
}

pub fn image(attributes: List(Attribute)) -> Element {
  element.element("image", attributes, [])
}

pub fn path(attributes: List(Attribute)) -> Element {
  element.element("path", attributes, [])
}

pub fn use_(attributes: List(Attribute)) -> Element {
  element.element("use", attributes, [])
}

pub fn fe_distant_light(attributes: List(Attribute)) -> Element {
  element.element("feDistantLight", attributes, [])
}

pub fn fe_point_light(attributes: List(Attribute)) -> Element {
  element.element("fePointLight", attributes, [])
}

pub fn fe_spot_light(attributes: List(Attribute)) -> Element {
  element.element("feSpotLight", attributes, [])
}

pub fn a(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("a", attributes, children)
}

pub fn defs(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("defs", attributes, children)
}

pub fn g(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("g", attributes, children)
}

pub fn marker(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("marker", attributes, children)
}

pub fn mask(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("mask", attributes, children)
}

pub fn pattern(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("pattern", attributes, children)
}

pub fn svg(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("svg", attributes, children)
}

pub fn switch(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("switch", attributes, children)
}

pub fn symbol(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("symbol", attributes, children)
}

pub fn view(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("view", attributes, children)
}

pub fn desc(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("desc", attributes, children)
}

pub fn metadata(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("metadata", attributes, children)
}

pub fn title(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("title", attributes, children)
}

pub fn filter(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("filter", attributes, children)
}

pub fn fe_component_transfer(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feComponentTransfer", attributes, children)
}

pub fn fe_diffuse_lighting(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feDiffuseLighting", attributes, children)
}

pub fn fe_displacement_map(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feDisplacementMap", attributes, children)
}

pub fn fe_merge(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feMerge", attributes, children)
}

pub fn fe_specular_lighting(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feSpecularLighting", attributes, children)
}

pub fn fe_tile(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("feTile", attributes, children)
}

pub fn linear_gradient(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("linearGradient", attributes, children)
}

pub fn radial_gradient(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("radialGradient", attributes, children)
}

pub fn clip_path(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("clipPath", attributes, children)
}

pub fn foreign_object(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("foreignObject", attributes, children)
}

pub fn text_path(
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  element.element("textPath", attributes, children)
}

pub fn tspan(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("tspan", attributes, children)
}

pub fn text(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("text", attributes, children)
}

pub fn style(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("style", attributes, children)
}

pub fn script(attributes: List(Attribute), children: List(Element)) -> Element {
  element.element("script", attributes, children)
}
