//// SVG attributes. Function names are snake_case (`stroke_width`); the
//// props are React's camelCase (`strokeWidth`), which React writes back
//// out as SVG's own name (`stroke-width`). Values are strings, since most
//// SVG numbers can also be lengths or percentages.

import fuller/attribute.{type Attribute}

pub fn xmlns(value: String) -> Attribute {
  attribute.attribute("xmlns", value)
}

pub fn view_box(value: String) -> Attribute {
  attribute.attribute("viewBox", value)
}

pub fn width(value: String) -> Attribute {
  attribute.attribute("width", value)
}

pub fn height(value: String) -> Attribute {
  attribute.attribute("height", value)
}

pub fn fill(value: String) -> Attribute {
  attribute.attribute("fill", value)
}

pub fn fill_opacity(value: String) -> Attribute {
  attribute.attribute("fillOpacity", value)
}

pub fn fill_rule(value: String) -> Attribute {
  attribute.attribute("fillRule", value)
}

pub fn stroke(value: String) -> Attribute {
  attribute.attribute("stroke", value)
}

pub fn stroke_width(value: String) -> Attribute {
  attribute.attribute("strokeWidth", value)
}

pub fn stroke_opacity(value: String) -> Attribute {
  attribute.attribute("strokeOpacity", value)
}

pub fn stroke_linecap(value: String) -> Attribute {
  attribute.attribute("strokeLinecap", value)
}

pub fn stroke_linejoin(value: String) -> Attribute {
  attribute.attribute("strokeLinejoin", value)
}

pub fn stroke_dasharray(value: String) -> Attribute {
  attribute.attribute("strokeDasharray", value)
}

pub fn stroke_dashoffset(value: String) -> Attribute {
  attribute.attribute("strokeDashoffset", value)
}

pub fn stroke_miterlimit(value: String) -> Attribute {
  attribute.attribute("strokeMiterlimit", value)
}

pub fn opacity(value: String) -> Attribute {
  attribute.attribute("opacity", value)
}

pub fn d(value: String) -> Attribute {
  attribute.attribute("d", value)
}

pub fn cx(value: String) -> Attribute {
  attribute.attribute("cx", value)
}

pub fn cy(value: String) -> Attribute {
  attribute.attribute("cy", value)
}

pub fn r(value: String) -> Attribute {
  attribute.attribute("r", value)
}

pub fn rx(value: String) -> Attribute {
  attribute.attribute("rx", value)
}

pub fn ry(value: String) -> Attribute {
  attribute.attribute("ry", value)
}

pub fn x(value: String) -> Attribute {
  attribute.attribute("x", value)
}

pub fn y(value: String) -> Attribute {
  attribute.attribute("y", value)
}

pub fn x1(value: String) -> Attribute {
  attribute.attribute("x1", value)
}

pub fn x2(value: String) -> Attribute {
  attribute.attribute("x2", value)
}

pub fn y1(value: String) -> Attribute {
  attribute.attribute("y1", value)
}

pub fn y2(value: String) -> Attribute {
  attribute.attribute("y2", value)
}

pub fn dx(value: String) -> Attribute {
  attribute.attribute("dx", value)
}

pub fn dy(value: String) -> Attribute {
  attribute.attribute("dy", value)
}

pub fn points(value: String) -> Attribute {
  attribute.attribute("points", value)
}

pub fn transform(value: String) -> Attribute {
  attribute.attribute("transform", value)
}

pub fn path_length(value: String) -> Attribute {
  attribute.attribute("pathLength", value)
}

pub fn preserve_aspect_ratio(value: String) -> Attribute {
  attribute.attribute("preserveAspectRatio", value)
}

pub fn offset(value: String) -> Attribute {
  attribute.attribute("offset", value)
}

pub fn stop_color(value: String) -> Attribute {
  attribute.attribute("stopColor", value)
}

pub fn stop_opacity(value: String) -> Attribute {
  attribute.attribute("stopOpacity", value)
}

pub fn gradient_units(value: String) -> Attribute {
  attribute.attribute("gradientUnits", value)
}

pub fn gradient_transform(value: String) -> Attribute {
  attribute.attribute("gradientTransform", value)
}

pub fn spread_method(value: String) -> Attribute {
  attribute.attribute("spreadMethod", value)
}

pub fn fx(value: String) -> Attribute {
  attribute.attribute("fx", value)
}

pub fn fy(value: String) -> Attribute {
  attribute.attribute("fy", value)
}

pub fn clip_path(value: String) -> Attribute {
  attribute.attribute("clipPath", value)
}

pub fn clip_rule(value: String) -> Attribute {
  attribute.attribute("clipRule", value)
}

pub fn clip_path_units(value: String) -> Attribute {
  attribute.attribute("clipPathUnits", value)
}

pub fn mask(value: String) -> Attribute {
  attribute.attribute("mask", value)
}

pub fn mask_units(value: String) -> Attribute {
  attribute.attribute("maskUnits", value)
}

pub fn marker_start(value: String) -> Attribute {
  attribute.attribute("markerStart", value)
}

pub fn marker_mid(value: String) -> Attribute {
  attribute.attribute("markerMid", value)
}

pub fn marker_end(value: String) -> Attribute {
  attribute.attribute("markerEnd", value)
}

pub fn marker_width(value: String) -> Attribute {
  attribute.attribute("markerWidth", value)
}

pub fn marker_height(value: String) -> Attribute {
  attribute.attribute("markerHeight", value)
}

pub fn ref_x(value: String) -> Attribute {
  attribute.attribute("refX", value)
}

pub fn ref_y(value: String) -> Attribute {
  attribute.attribute("refY", value)
}

pub fn orient(value: String) -> Attribute {
  attribute.attribute("orient", value)
}

pub fn font_family(value: String) -> Attribute {
  attribute.attribute("fontFamily", value)
}

pub fn font_size(value: String) -> Attribute {
  attribute.attribute("fontSize", value)
}

pub fn font_weight(value: String) -> Attribute {
  attribute.attribute("fontWeight", value)
}

pub fn font_style(value: String) -> Attribute {
  attribute.attribute("fontStyle", value)
}

pub fn text_anchor(value: String) -> Attribute {
  attribute.attribute("textAnchor", value)
}

pub fn dominant_baseline(value: String) -> Attribute {
  attribute.attribute("dominantBaseline", value)
}

pub fn letter_spacing(value: String) -> Attribute {
  attribute.attribute("letterSpacing", value)
}

pub fn href(value: String) -> Attribute {
  attribute.attribute("href", value)
}

pub fn xlink_href(value: String) -> Attribute {
  attribute.attribute("xlinkHref", value)
}

pub fn vector_effect(value: String) -> Attribute {
  attribute.attribute("vectorEffect", value)
}

pub fn color(value: String) -> Attribute {
  attribute.attribute("color", value)
}

pub fn visibility(value: String) -> Attribute {
  attribute.attribute("visibility", value)
}

pub fn pattern_units(value: String) -> Attribute {
  attribute.attribute("patternUnits", value)
}

pub fn pattern_transform(value: String) -> Attribute {
  attribute.attribute("patternTransform", value)
}

pub fn filter_units(value: String) -> Attribute {
  attribute.attribute("filterUnits", value)
}

pub fn std_deviation(value: String) -> Attribute {
  attribute.attribute("stdDeviation", value)
}

pub fn in_(value: String) -> Attribute {
  attribute.attribute("in", value)
}

pub fn in2(value: String) -> Attribute {
  attribute.attribute("in2", value)
}

pub fn result(value: String) -> Attribute {
  attribute.attribute("result", value)
}

pub fn mode(value: String) -> Attribute {
  attribute.attribute("mode", value)
}

pub fn operator(value: String) -> Attribute {
  attribute.attribute("operator", value)
}

pub fn values(value: String) -> Attribute {
  attribute.attribute("values", value)
}

pub fn type_(value: String) -> Attribute {
  attribute.attribute("type", value)
}

pub fn begin(value: String) -> Attribute {
  attribute.attribute("begin", value)
}

pub fn dur(value: String) -> Attribute {
  attribute.attribute("dur", value)
}

pub fn repeat_count(value: String) -> Attribute {
  attribute.attribute("repeatCount", value)
}

pub fn attribute_name(value: String) -> Attribute {
  attribute.attribute("attributeName", value)
}

pub fn from(value: String) -> Attribute {
  attribute.attribute("from", value)
}

pub fn to(value: String) -> Attribute {
  attribute.attribute("to", value)
}

pub fn key_times(value: String) -> Attribute {
  attribute.attribute("keyTimes", value)
}

pub fn calc_mode(value: String) -> Attribute {
  attribute.attribute("calcMode", value)
}

pub fn shape_rendering(value: String) -> Attribute {
  attribute.attribute("shapeRendering", value)
}

pub fn text_length(value: String) -> Attribute {
  attribute.attribute("textLength", value)
}

pub fn length_adjust(value: String) -> Attribute {
  attribute.attribute("lengthAdjust", value)
}

pub fn pointer_events(value: String) -> Attribute {
  attribute.attribute("pointerEvents", value)
}

pub fn paint_order(value: String) -> Attribute {
  attribute.attribute("paintOrder", value)
}

pub fn transform_origin(value: String) -> Attribute {
  attribute.attribute("transformOrigin", value)
}
