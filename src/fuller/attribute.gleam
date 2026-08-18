//// Props. Names are React's, so `className` and `htmlFor`.  

pub type Attribute {
  Attribute(name: String, value: String)
  IntAttribute(name: String, value: Int)
  FloatAttribute(name: String, value: Float)
  BoolAttribute(name: String, value: Bool)
  /// Property names are React's camelCase, like `backgroundColor`.
  Style(properties: List(#(String, String)))
  InnerHtml(html: String)
}

pub fn attribute(name: String, value: String) -> Attribute {
  Attribute(name:, value:)
}

pub fn int(name: String, value: Int) -> Attribute {
  IntAttribute(name:, value:)
}

pub fn float(name: String, value: Float) -> Attribute {
  FloatAttribute(name:, value:)
}

pub fn bool(name: String, value: Bool) -> Attribute {
  BoolAttribute(name:, value:)
}

pub fn style(properties: List(#(String, String))) -> Attribute {
  Style(properties:)
}

pub fn dangerously_set_inner_html(html: String) -> Attribute {
  InnerHtml(html:)
}

pub fn class(name: String) -> Attribute {
  Attribute("className", name)
}

pub fn id(value: String) -> Attribute {
  Attribute("id", value)
}

pub fn href(url: String) -> Attribute {
  Attribute("href", url)
}

pub fn src(url: String) -> Attribute {
  Attribute("src", url)
}

pub fn alt(text: String) -> Attribute {
  Attribute("alt", text)
}

pub fn title(text: String) -> Attribute {
  Attribute("title", text)
}

pub fn lang(code: String) -> Attribute {
  Attribute("lang", code)
}

pub fn rel(value: String) -> Attribute {
  Attribute("rel", value)
}

pub fn target(value: String) -> Attribute {
  Attribute("target", value)
}

pub fn role(value: String) -> Attribute {
  Attribute("role", value)
}

pub fn name(value: String) -> Attribute {
  Attribute("name", value)
}

pub fn value(value: String) -> Attribute {
  Attribute("value", value)
}

pub fn placeholder(text: String) -> Attribute {
  Attribute("placeholder", text)
}

pub fn type_(value: String) -> Attribute {
  Attribute("type", value)
}

pub fn for(id: String) -> Attribute {
  Attribute("htmlFor", id)
}

pub fn width(px: Int) -> Attribute {
  IntAttribute("width", px)
}

pub fn height(px: Int) -> Attribute {
  IntAttribute("height", px)
}

pub fn disabled(is_disabled: Bool) -> Attribute {
  BoolAttribute("disabled", is_disabled)
}

pub fn checked(is_checked: Bool) -> Attribute {
  BoolAttribute("checked", is_checked)
}

pub fn hidden(is_hidden: Bool) -> Attribute {
  BoolAttribute("hidden", is_hidden)
}

pub fn data(key: String, value: String) -> Attribute {
  Attribute("data-" <> key, value)
}

pub fn aria(key: String, value: String) -> Attribute {
  Attribute("aria-" <> key, value)
}
