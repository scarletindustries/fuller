import fuller/attribute.{type Attribute}

pub type Element {
  Element(tag: String, attributes: List(Attribute), children: List(Element))
  Text(content: String)
  Fragment(children: List(Element))
  None
}

pub fn element(
  tag: String,
  attributes: List(Attribute),
  children: List(Element),
) -> Element {
  Element(tag:, attributes:, children:)
}

pub fn text(content: String) -> Element {
  Text(content:)
}

pub fn fragment(children: List(Element)) -> Element {
  Fragment(children:)
}

pub fn none() -> Element {
  None
}
