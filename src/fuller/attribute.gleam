//// Attributes for HTML elements, passed to React as props.
////
//// Function names follow HTML (`readonly`, `tabindex`, `for`, `class`), so
//// you can look them up on MDN. The props they set are React's (`readOnly`,
//// `tabIndex`, `htmlFor`, `className`), and React's server renderer turns
//// those back into HTML attributes. Where a function's docs mention a prop,
//// that is the React name.
////
//// ```gleam
//// import fuller/attribute
//// import fuller/element/html
////
//// html.input([
////   attribute.type_("email"),
////   attribute.name("email"),
////   attribute.readonly(True),
////   attribute.tabindex(0),
//// ])
//// // <input type="email" name="email" readOnly="" tabindex="0"/>
//// ```
////
//// For anything without a helper, use `attribute`, `int`, `float` or `bool`
//// with React's prop name.

import gleam/list
import gleam/string

/// A prop on an element. Build one with the functions in this module rather
/// than the constructors, which take React prop names as-is.
pub type Attribute {
  /// A prop with a string value. `name` is React's prop name.
  Attribute(name: String, value: String)
  /// A prop with an integer value, passed to React as a number.
  IntAttribute(name: String, value: Int)
  /// A prop with a float value, passed to React as a number.
  FloatAttribute(name: String, value: Float)
  /// A prop with a boolean value. How React renders it depends on the prop:
  /// HTML booleans like `disabled` render as `name=""` or are left out,
  /// `aria-*` and `data-*` render `"true"` / `"false"`, and React drops
  /// booleans on props it doesn't know as boolean.
  BoolAttribute(name: String, value: Bool)
  /// Inline styles. Property names are React's camelCase, like
  /// `backgroundColor`.
  Style(properties: List(#(String, String)))
  /// Raw HTML for the element's content, React's `dangerouslySetInnerHTML`.
  InnerHtml(html: String)
}

/// Any string prop, for attributes this module has no helper for. `name`
/// must be React's prop name (`"autoCorrect"`, `"data-id"`), not
/// necessarily the HTML name. React passes unknown names through as-is.
///
/// ```gleam
/// attribute.attribute("autoCorrect", "off")
/// ```
///
/// [React reference](https://react.dev/reference/react-dom/components/common)
pub fn attribute(name: String, value: String) -> Attribute {
  Attribute(name:, value:)
}

/// Any integer prop, for numeric attributes this module has no helper for.
/// `name` must be React's prop name.
///
/// [React reference](https://react.dev/reference/react-dom/components/common)
pub fn int(name: String, value: Int) -> Attribute {
  IntAttribute(name:, value:)
}

/// Any float prop, for numeric attributes this module has no helper for.
/// `name` must be React's prop name.
///
/// [React reference](https://react.dev/reference/react-dom/components/common)
pub fn float(name: String, value: Float) -> Attribute {
  FloatAttribute(name:, value:)
}

/// Any boolean prop, for attributes this module has no helper for. `name`
/// must be React's prop name (`"disablePictureInPicture"`). React only
/// renders booleans for props it knows are boolean, plus `aria-*` and
/// `data-*`; on any other prop the attribute is dropped.
///
/// [React reference](https://react.dev/reference/react-dom/components/common)
pub fn bool(name: String, value: Bool) -> Attribute {
  BoolAttribute(name:, value:)
}

/// Inline CSS styles, as property/value pairs. Property names are React's
/// camelCase (`backgroundColor`, not `background-color`); custom properties
/// keep their `--` name.
///
/// ```gleam
/// attribute.style([#("backgroundColor", "black"), #("--gap", "4px")])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/style)
pub fn style(properties: List(#(String, String))) -> Attribute {
  Style(properties:)
}

/// Sets the element's content to raw, unescaped HTML. Never pass
/// user-supplied text here: anything in it, `<script>` included, ends up in
/// the page (XSS). The element must have no other children.
///
/// [React reference](https://react.dev/reference/react-dom/components/common#dangerously-setting-the-inner-html)
pub fn dangerously_set_inner_html(html: String) -> Attribute {
  InnerHtml(html:)
}

/// Space-separated CSS class names. Sets React's `className` prop, rendered
/// as `class`. Use `classes` to toggle names conditionally.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/class)
pub fn class(name: String) -> Attribute {
  Attribute("className", name)
}

/// A unique identifier for the element in the document, used by fragment
/// links, `for`, `aria-*` references and CSS.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/id)
pub fn id(value: String) -> Attribute {
  Attribute("id", value)
}

/// The URL a link points to, on `<a>`, `<area>`, `<link>` and `<base>`.
/// React drops an empty string and replaces `javascript:` URLs with one that
/// throws.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a#href)
pub fn href(url: String) -> Attribute {
  Attribute("href", url)
}

/// The URL of embedded content, on `<img>`, `<script>`, `<iframe>`,
/// `<video>`, `<audio>`, `<source>`, `<track>` and `<input type="image">`.
/// React drops an empty string and replaces `javascript:` URLs with one that
/// throws.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#src)
pub fn src(url: String) -> Attribute {
  Attribute("src", url)
}

/// Text that replaces an image when it can't be shown, and is read by
/// screen readers. Use `""` for decorative images.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#alt)
pub fn alt(text: String) -> Attribute {
  Attribute("alt", text)
}

/// Advisory text about the element, usually shown as a tooltip.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/title)
pub fn title(text: String) -> Attribute {
  Attribute("title", text)
}

/// The language of the element's content, as a BCP 47 tag like `"en"` or
/// `"pt-BR"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/lang)
pub fn lang(code: String) -> Attribute {
  Attribute("lang", code)
}

/// The relationship of the linked resource to the current document, as
/// space-separated keywords like `"noopener noreferrer"` or `"stylesheet"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/rel)
pub fn rel(value: String) -> Attribute {
  Attribute("rel", value)
}

/// Where to open a link or form result: `"_self"`, `"_blank"`,
/// `"_parent"`, `"_top"`, or a named browsing context.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a#target)
pub fn target(value: String) -> Attribute {
  Attribute("target", value)
}

/// The element's ARIA role, like `"button"` or `"navigation"`. Prefer the
/// native element when one exists.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Roles)
pub fn role(value: String) -> Attribute {
  Attribute("role", value)
}

/// The name a form control's value is submitted under. Also names
/// `<iframe>`, `<meta>`, `<map>`, `<slot>` and grouped `<details>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#name)
pub fn name(value: String) -> Attribute {
  Attribute("name", value)
}

/// The value of a form control. On `<textarea>` React renders it as the
/// text content; on `<select>` it marks the matching `<option>` as
/// selected. Use `default_value` for the same initial value without
/// making the field controlled on the client.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#value)
pub fn value(value: String) -> Attribute {
  Attribute("value", value)
}

/// Hint text shown in an empty `<input>` or `<textarea>`. Not a substitute
/// for a `<label>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#placeholder)
pub fn placeholder(text: String) -> Attribute {
  Attribute("placeholder", text)
}

/// The type of an `<input>` (`"text"`, `"email"`, `"checkbox"`, ...) or
/// `<button>` (`"submit"`, `"button"`, `"reset"`), or the MIME type of a
/// `<script>`, `<link>`, `<source>` or `<embed>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#type)
pub fn type_(value: String) -> Attribute {
  Attribute("type", value)
}

/// The `id` of the form control a `<label>` or `<output>` belongs to. Sets
/// React's `htmlFor` prop, rendered as `for`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/for)
pub fn for(id: String) -> Attribute {
  Attribute("htmlFor", id)
}

/// The width in CSS pixels, on `<img>`, `<canvas>`, `<video>`, `<iframe>`,
/// `<embed>`, `<object>`, `<source>` and `<input type="image">`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#width)
pub fn width(px: Int) -> Attribute {
  IntAttribute("width", px)
}

/// The height in CSS pixels, on `<img>`, `<canvas>`, `<video>`, `<iframe>`,
/// `<embed>`, `<object>`, `<source>` and `<input type="image">`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#height)
pub fn height(px: Int) -> Attribute {
  IntAttribute("height", px)
}

/// Disables a form control or `<fieldset>`: it can't be focused or edited
/// and isn't submitted. `True` renders `disabled=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/disabled)
pub fn disabled(is_disabled: Bool) -> Attribute {
  BoolAttribute("disabled", is_disabled)
}

/// Whether a checkbox or radio `<input>` is checked. `True` renders
/// `checked=""`; `False` leaves it out. Use `default_checked` for the same
/// initial state without making the input controlled on the client.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#checked)
pub fn checked(is_checked: Bool) -> Attribute {
  BoolAttribute("checked", is_checked)
}

/// Hides the element: browsers don't render it. `True` renders
/// `hidden=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/hidden)
pub fn hidden(is_hidden: Bool) -> Attribute {
  BoolAttribute("hidden", is_hidden)
}

/// A custom `data-*` attribute. `key` gets the `data-` prefix, so
/// `data("user-id", "42")` renders `data-user-id="42"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/data-*)
pub fn data(key: String, value: String) -> Attribute {
  Attribute("data-" <> key, value)
}

/// Any `aria-*` attribute. `key` gets the `aria-` prefix, so
/// `aria("label", "Close")` renders `aria-label="Close"`. Prefer the typed
/// `aria_*` helpers below where one exists.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes)
pub fn aria(key: String, value: String) -> Attribute {
  Attribute("aria-" <> key, value)
}

/// A keyboard shortcut hint for focusing or activating the element, as a
/// single character. Sets React's `accessKey` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/accesskey)
pub fn accesskey(value: String) -> Attribute {
  Attribute("accessKey", value)
}

/// How virtual keyboards capitalize typed text: `"none"`, `"sentences"`,
/// `"words"` or `"characters"`. Sets React's `autoCapitalize` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autocapitalize)
pub fn autocapitalize(value: String) -> Attribute {
  Attribute("autoCapitalize", value)
}

/// Focuses the element when the page loads. Sets React's `autoFocus` prop,
/// rendered as `autofocus=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/autofocus)
pub fn autofocus(value: Bool) -> Attribute {
  BoolAttribute("autoFocus", value)
}

/// Whether the user can edit the element's content: `"true"`, `"false"` or
/// `"plaintext-only"`. Sets React's `contentEditable` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/contenteditable)
pub fn contenteditable(value: String) -> Attribute {
  Attribute("contentEditable", value)
}

/// Text direction: `"ltr"`, `"rtl"` or `"auto"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/dir)
pub fn dir(value: String) -> Attribute {
  Attribute("dir", value)
}

/// Whether the element can be dragged. Renders `draggable="true"` or
/// `draggable="false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/draggable)
pub fn draggable(value: Bool) -> Attribute {
  BoolAttribute("draggable", value)
}

/// The label of the enter key on virtual keyboards: `"enter"`, `"done"`,
/// `"go"`, `"next"`, `"previous"`, `"search"` or `"send"`. Sets React's
/// `enterKeyHint` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/enterkeyhint)
pub fn enterkeyhint(value: String) -> Attribute {
  Attribute("enterKeyHint", value)
}

/// Makes the element and its subtree non-interactive: no focus, clicks or
/// assistive tech. `True` renders `inert=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/inert)
pub fn inert(value: Bool) -> Attribute {
  BoolAttribute("inert", value)
}

/// Which virtual keyboard to show: `"none"`, `"text"`, `"decimal"`,
/// `"numeric"`, `"tel"`, `"search"`, `"email"` or `"url"`. Sets React's
/// `inputMode` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/inputmode)
pub fn inputmode(value: String) -> Attribute {
  Attribute("inputMode", value)
}

/// The name of a customized built-in element to use, like
/// `"word-count"` on a `<p>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/is)
pub fn is(value: String) -> Attribute {
  Attribute("is", value)
}

/// The global identifier of a microdata item. Sets React's `itemID` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/itemid)
pub fn itemid(value: String) -> Attribute {
  Attribute("itemID", value)
}

/// The name of a microdata property on its item. Sets React's `itemProp`
/// prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/itemprop)
pub fn itemprop(value: String) -> Attribute {
  Attribute("itemProp", value)
}

/// Marks the element as a microdata item. Sets React's `itemScope` prop;
/// `True` renders `itemScope=""` and `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/itemscope)
pub fn itemscope(value: Bool) -> Attribute {
  BoolAttribute("itemScope", value)
}

/// The vocabulary URL of a microdata item, like
/// `"https://schema.org/Person"`. Sets React's `itemType` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/itemtype)
pub fn itemtype(value: String) -> Attribute {
  Attribute("itemType", value)
}

/// A one-time token that lets a `<script>` or `<style>` run under a
/// Content Security Policy.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/nonce)
pub fn nonce(value: String) -> Attribute {
  Attribute("nonce", value)
}

/// Makes the element a popover: `"auto"`, `"manual"` or `"hint"`. Open it
/// with `popovertarget` on a button.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/popover)
pub fn popover(value: String) -> Attribute {
  Attribute("popover", value)
}

/// Whether the browser spell-checks the element's editable content. Sets
/// React's `spellCheck` prop, rendered as `"true"` or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/spellcheck)
pub fn spellcheck(value: Bool) -> Attribute {
  BoolAttribute("spellCheck", value)
}

/// The element's place in keyboard focus order: `0` for document order,
/// `-1` for focusable only from script. Avoid positive values. Sets React's
/// `tabIndex` prop, rendered as `tabindex`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/tabindex)
pub fn tabindex(value: Int) -> Attribute {
  IntAttribute("tabIndex", value)
}

/// Whether a `<details>` or `<dialog>` is open. `True` renders `open=""`;
/// `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/details#open)
pub fn open(value: Bool) -> Attribute {
  BoolAttribute("open", value)
}

/// The language of the linked resource, as a BCP 47 tag, on `<a>` and
/// `<link>`. Sets React's `hrefLang` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a#hreflang)
pub fn hreflang(value: String) -> Attribute {
  Attribute("hrefLang", value)
}

/// How much referrer information to send, like `"no-referrer"` or
/// `"strict-origin-when-cross-origin"`. Sets React's `referrerPolicy` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a#referrerpolicy)
pub fn referrerpolicy(value: String) -> Attribute {
  Attribute("referrerPolicy", value)
}

/// The kind of resource a `<link rel="preload">` fetches, like `"script"`,
/// `"style"`, `"font"` or `"image"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/link#as)
pub fn as_(value: String) -> Attribute {
  Attribute("as", value)
}

/// A Subresource Integrity hash for a `<script>` or `<link>`, like
/// `"sha384-..."`. The browser refuses the resource if it doesn't match.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script#integrity)
pub fn integrity(value: String) -> Attribute {
  Attribute("integrity", value)
}

/// Candidate image sources with width (`w`) or density (`x`) descriptors,
/// comma-separated, on `<img>` and `<source>`. Sets React's `srcSet` prop.
///
/// ```gleam
/// html.img([
///   attribute.src("/cat-480.jpg"),
///   attribute.srcset("/cat-480.jpg 480w, /cat-960.jpg 960w"),
///   attribute.sizes("(max-width: 600px) 480px, 960px"),
///   attribute.alt("A cat"),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#srcset)
pub fn srcset(value: String) -> Attribute {
  Attribute("srcSet", value)
}

/// The image's display width under media conditions, comma-separated, used
/// to pick from `srcset` width descriptors. On `<img>`, `<source>` and
/// `<link>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#sizes)
pub fn sizes(value: String) -> Attribute {
  Attribute("sizes", value)
}

/// The CORS mode for fetching the resource: `"anonymous"` or
/// `"use-credentials"`. Sets React's `crossOrigin` prop, rendered as
/// `crossorigin`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/crossorigin)
pub fn crossorigin(value: String) -> Attribute {
  Attribute("crossOrigin", value)
}

/// The image map to use for an `<img>`, as `"#"` plus the `<map>` name.
/// Sets React's `useMap` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#usemap)
pub fn usemap(value: String) -> Attribute {
  Attribute("useMap", value)
}

/// Makes an `<img>` inside a link a server-side image map, sending click
/// coordinates with the URL. Renders `isMap=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#ismap)
pub fn ismap(value: Bool) -> Attribute {
  // React has no boolean handling for isMap: it drops a true and false
  // alike, so true goes over as an empty string and false stays a boolean
  case value {
    True -> Attribute("isMap", "")
    False -> BoolAttribute("isMap", False)
  }
}

/// An image decoding hint: `"sync"`, `"async"` or `"auto"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#decoding)
pub fn decoding(value: String) -> Attribute {
  Attribute("decoding", value)
}

/// When to load an `<img>` or `<iframe>`: `"eager"` or `"lazy"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#loading)
pub fn loading(value: String) -> Attribute {
  Attribute("loading", value)
}

/// The fetch priority hint: `"high"`, `"low"` or `"auto"`, on `<img>`,
/// `<link>` and `<script>`. Sets React's `fetchPriority` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/img#fetchpriority)
pub fn fetchpriority(value: String) -> Attribute {
  Attribute("fetchPriority", value)
}

/// The character encodings a `<form>` accepts; in practice only
/// `"UTF-8"`. Sets React's `acceptCharset` prop, rendered as
/// `accept-charset`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form#accept-charset)
pub fn accept_charset(value: String) -> Attribute {
  Attribute("acceptCharset", value)
}

/// The URL a `<form>` submits to. React replaces `javascript:` URLs with
/// one that throws.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form#action)
pub fn action(value: String) -> Attribute {
  Attribute("action", value)
}

/// How a `<form>` encodes its data: `"application/x-www-form-urlencoded"`,
/// `"multipart/form-data"` (needed for file uploads) or `"text/plain"`.
/// Sets React's `encType` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form#enctype)
pub fn enctype(value: String) -> Attribute {
  Attribute("encType", value)
}

/// The HTTP method a `<form>` submits with: `"get"`, `"post"` or
/// `"dialog"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form#method)
pub fn method(value: String) -> Attribute {
  Attribute("method", value)
}

/// Skips built-in validation when the `<form>` is submitted. Sets React's
/// `noValidate` prop; `True` renders `noValidate=""` and `False` leaves it
/// out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/form#novalidate)
pub fn novalidate(value: Bool) -> Attribute {
  BoolAttribute("noValidate", value)
}

/// Autofill hint for a form control or `<form>`, like `"off"`, `"email"`,
/// `"current-password"` or `"street-address"`. Sets React's `autoComplete`
/// prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/autocomplete)
pub fn autocomplete(value: String) -> Attribute {
  Attribute("autoComplete", value)
}

/// The initial checked state of a checkbox or radio `<input>`, which the
/// user can then change. React renders it as `checked=""`. Applies to form
/// fields only.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#checked)
pub fn default_checked(value: Bool) -> Attribute {
  BoolAttribute("defaultChecked", value)
}

/// The visible width of a `<textarea>` in characters. Must be at least 1,
/// or React leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/textarea#cols)
pub fn cols(value: Int) -> Attribute {
  IntAttribute("cols", value)
}

/// The field name under which an `<input>` or `<textarea>`'s text
/// direction is submitted. Sets React's `dirName` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/dirname)
pub fn dirname(value: String) -> Attribute {
  Attribute("dirName", value)
}

/// The `id` of the `<form>` a control belongs to, when it isn't nested
/// inside it.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#form)
pub fn form(value: String) -> Attribute {
  Attribute("form", value)
}

/// Overrides the form's `action` for a submit `<button>` or `<input>`. Sets
/// React's `formAction` prop. React replaces `javascript:` URLs with one
/// that throws.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#formaction)
pub fn formaction(value: String) -> Attribute {
  Attribute("formAction", value)
}

/// Overrides the form's `enctype` for a submit button. Sets React's
/// `formEncType` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#formenctype)
pub fn formenctype(value: String) -> Attribute {
  Attribute("formEncType", value)
}

/// Overrides the form's `method` for a submit button: `"get"`, `"post"` or
/// `"dialog"`. Sets React's `formMethod` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#formmethod)
pub fn formmethod(value: String) -> Attribute {
  Attribute("formMethod", value)
}

/// Skips form validation when this submit button is used. Sets React's
/// `formNoValidate` prop; `True` renders `formNoValidate=""` and `False`
/// leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#formnovalidate)
pub fn formnovalidate(value: Bool) -> Attribute {
  BoolAttribute("formNoValidate", value)
}

/// Overrides the form's `target` for a submit button. Sets React's
/// `formTarget` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#formtarget)
pub fn formtarget(value: String) -> Attribute {
  Attribute("formTarget", value)
}

/// The `id` of a `<datalist>` offering suggestions for an `<input>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#list)
pub fn list(value: String) -> Attribute {
  Attribute("list", value)
}

/// The maximum allowed value of an `<input>` (a number, date or time in
/// the input's format), or the upper bound of a `<meter>` or `<progress>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/max)
pub fn max(value: String) -> Attribute {
  Attribute("max", value)
}

/// The maximum length, in UTF-16 code units, of an `<input>` or
/// `<textarea>` value. Sets React's `maxLength` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/maxlength)
pub fn maxlength(value: Int) -> Attribute {
  IntAttribute("maxLength", value)
}

/// The minimum allowed value of an `<input>` (a number, date or time in
/// the input's format), or the lower bound of a `<meter>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/min)
pub fn min(value: String) -> Attribute {
  Attribute("min", value)
}

/// The minimum length, in UTF-16 code units, of an `<input>` or
/// `<textarea>` value. Sets React's `minLength` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/minlength)
pub fn minlength(value: Int) -> Attribute {
  IntAttribute("minLength", value)
}

/// Allows more than one value: several options in a `<select>`, or several
/// files or emails in an `<input>`. `True` renders `multiple=""`; `False`
/// leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/multiple)
pub fn multiple(value: Bool) -> Attribute {
  BoolAttribute("multiple", value)
}

/// A regular expression the whole `<input>` value must match, without
/// surrounding slashes.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/pattern)
pub fn pattern(value: String) -> Attribute {
  Attribute("pattern", value)
}

/// The `id` of a popover element a `<button>` or `<input>` controls. Sets
/// React's `popoverTarget` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#popovertarget)
pub fn popovertarget(value: String) -> Attribute {
  Attribute("popoverTarget", value)
}

/// What a `popovertarget` button does: `"toggle"`, `"show"` or `"hide"`.
/// Sets React's `popoverTargetAction` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/button#popovertargetaction)
pub fn popovertargetaction(value: String) -> Attribute {
  Attribute("popoverTargetAction", value)
}

/// Marks a form field as read-only: the user can't edit it, but its value is
/// still submitted. Sets React's `readOnly` prop; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/readonly)
pub fn readonly(value: Bool) -> Attribute {
  BoolAttribute("readOnly", value)
}

/// Marks a form field as required: the form won't submit while it's
/// empty. `True` renders `required=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/required)
pub fn required(value: Bool) -> Attribute {
  BoolAttribute("required", value)
}

/// The visible number of text lines in a `<textarea>`. Must be at least 1,
/// or React leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/textarea#rows)
pub fn rows(value: Int) -> Attribute {
  IntAttribute("rows", value)
}

/// Marks an `<option>` as selected. React warns about this; set `value` or
/// `default_value` on the `<select>` instead.
///
/// ```gleam
/// html.select([attribute.name("size"), attribute.default_value("m")], [
///   html.option([attribute.value("s")], [html.text("Small")]),
///   html.option([attribute.value("m")], [html.text("Medium")]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/option#selected)
pub fn selected(value: Bool) -> Attribute {
  BoolAttribute("selected", value)
}

/// The visible width of an `<input>` in characters, or the number of
/// visible rows in a `<select>`. Must be at least 1, or React leaves it
/// out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/size)
pub fn size(value: Int) -> Attribute {
  IntAttribute("size", value)
}

/// The granularity of a numeric, date or time `<input>`, like `"0.01"`, or
/// `"any"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/step)
pub fn step(value: String) -> Attribute {
  Attribute("step", value)
}

/// The initial value of a form field, which the user can then change. On
/// `<input>` React renders it as `value`; on `<textarea>` as the text
/// content; on `<select>` it marks the matching `<option>` as selected.
/// Applies to form fields only.
///
/// [React reference](https://react.dev/reference/react-dom/components/input)
pub fn default_value(value: String) -> Attribute {
  Attribute("defaultValue", value)
}

/// Makes a `<meta>` act like an HTTP header, like `"refresh"` or
/// `"content-security-policy"`; the value goes in `content`. Sets React's
/// `httpEquiv` prop, rendered as `http-equiv`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta#http-equiv)
pub fn http_equiv(value: String) -> Attribute {
  Attribute("httpEquiv", value)
}

/// The value of a `<meta>` element, paired with its `name` or `http_equiv`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta#content)
pub fn content(value: String) -> Attribute {
  Attribute("content", value)
}

/// The document's character encoding on `<meta>`; must be `"utf-8"`. Sets
/// React's `charSet` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meta#charset)
pub fn charset(value: String) -> Attribute {
  Attribute("charSet", value)
}

/// A media query the resource applies to, like `"(min-width: 600px)"`, on
/// `<link>`, `<style>`, `<source>` and `<meta name="theme-color">`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/link#media)
pub fn media(value: String) -> Attribute {
  Attribute("media", value)
}

/// Starts `<video>` or `<audio>` playback as soon as possible. Browsers
/// usually block it unless the media is `muted`. Sets React's `autoPlay`
/// prop; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video#autoplay)
pub fn autoplay(value: Bool) -> Attribute {
  BoolAttribute("autoPlay", value)
}

/// Shows the browser's playback controls on `<video>` or `<audio>`. `True`
/// renders `controls=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video#controls)
pub fn controls(value: Bool) -> Attribute {
  BoolAttribute("controls", value)
}

/// Restarts `<video>` or `<audio>` when it ends. `True` renders `loop=""`;
/// `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video#loop)
pub fn loop(value: Bool) -> Attribute {
  BoolAttribute("loop", value)
}

/// Starts `<video>` or `<audio>` with sound off. `True` renders
/// `muted=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video#muted)
pub fn muted(value: Bool) -> Attribute {
  BoolAttribute("muted", value)
}

/// Plays a `<video>` inline instead of fullscreen on mobile. Sets React's
/// `playsInline` prop; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video#playsinline)
pub fn playsinline(value: Bool) -> Attribute {
  BoolAttribute("playsInline", value)
}

/// The URL of an image shown before a `<video>` plays.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video#poster)
pub fn poster(value: String) -> Attribute {
  Attribute("poster", value)
}

/// How much of a `<video>` or `<audio>` to load up front: `"none"`,
/// `"metadata"` or `"auto"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/video#preload)
pub fn preload(value: String) -> Attribute {
  Attribute("preload", value)
}

/// A short label for a `<th>` header cell, used by assistive tech.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/th#abbr)
pub fn abbr(value: String) -> Attribute {
  Attribute("abbr", value)
}

/// How many columns a `<td>` or `<th>` spans. Sets React's `colSpan` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/td#colspan)
pub fn colspan(value: Int) -> Attribute {
  IntAttribute("colSpan", value)
}

/// How many rows a `<td>` or `<th>` spans; `0` extends to the end of the
/// table section. Sets React's `rowSpan` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/td#rowspan)
pub fn rowspan(value: Int) -> Attribute {
  IntAttribute("rowSpan", value)
}

/// How many columns a `<col>` or `<colgroup>` covers. Must be at least 1,
/// or React leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/col#span)
pub fn span(value: Int) -> Attribute {
  IntAttribute("span", value)
}

/// Which cells a `<th>` is a header for: `"row"`, `"col"`, `"rowgroup"` or
/// `"colgroup"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/th#scope)
pub fn scope(value: String) -> Attribute {
  Attribute("scope", value)
}

/// A machine-readable date or time on `<time>`, `<ins>` and `<del>`, like
/// `"2026-10-01"` or `"2026-10-01T09:30Z"`. Sets React's `dateTime` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/time#datetime)
pub fn datetime(value: String) -> Attribute {
  Attribute("dateTime", value)
}

/// Runs a `<script>` as soon as it downloads, without blocking parsing.
/// `True` renders `async=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script#async)
pub fn async(value: Bool) -> Attribute {
  BoolAttribute("async", value)
}

/// Runs a classic `<script>` after the document is parsed. `True` renders
/// `defer=""`; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script#defer)
pub fn defer(value: Bool) -> Attribute {
  BoolAttribute("defer", value)
}

/// Skips a `<script>` in browsers that support ES modules, for legacy
/// fallbacks. Sets React's `noModule` prop; `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script#nomodule)
pub fn nomodule(value: Bool) -> Attribute {
  BoolAttribute("noModule", value)
}

/// Numbers an `<ol>` in descending order. `True` renders `reversed=""`;
/// `False` leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ol#reversed)
pub fn reversed(value: Bool) -> Attribute {
  BoolAttribute("reversed", value)
}

/// The number an `<ol>` starts counting from.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/ol#start)
pub fn start(value: Int) -> Attribute {
  IntAttribute("start", value)
}

/// A label for an `<option>`, `<optgroup>` or `<track>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/option#label)
pub fn label(value: String) -> Attribute {
  Attribute("label", value)
}

/// The lower bound of the "high" range of a `<meter>`, as a number.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meter#high)
pub fn high(value: String) -> Attribute {
  Attribute("high", value)
}

/// The upper bound of the "low" range of a `<meter>`, as a number.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meter#low)
pub fn low(value: String) -> Attribute {
  Attribute("low", value)
}

/// The optimal value of a `<meter>`, as a number.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/meter#optimum)
pub fn optimum(value: String) -> Attribute {
  Attribute("optimum", value)
}

/// How a `<textarea>` wraps submitted text: `"soft"`, `"hard"` (needs
/// `cols`) or `"off"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/textarea#wrap)
pub fn wrap(value: String) -> Attribute {
  Attribute("wrap", value)
}

/// Inline HTML to show in an `<iframe>`, instead of loading `src`. Sets
/// React's `srcDoc` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe#srcdoc)
pub fn srcdoc(value: String) -> Attribute {
  Attribute("srcDoc", value)
}

/// Restrictions on an `<iframe>`'s content. `""` applies all of them;
/// space-separated tokens like `"allow-scripts allow-forms"` lift some.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe#sandbox)
pub fn sandbox(value: String) -> Attribute {
  Attribute("sandbox", value)
}

/// The Permissions Policy for an `<iframe>`, like
/// `"fullscreen; clipboard-write"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe#allow)
pub fn allow(value: String) -> Attribute {
  Attribute("allow", value)
}

/// Lets an `<iframe>` go fullscreen; legacy, prefer
/// `allow("fullscreen")`. Sets React's `allowFullScreen` prop; `False`
/// leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe#allowfullscreen)
pub fn allowfullscreen(value: Bool) -> Attribute {
  BoolAttribute("allowFullScreen", value)
}

/// The language of a `<track>`'s text, as a BCP 47 tag. Sets React's
/// `srcLang` prop.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/track#srclang)
pub fn srclang(value: String) -> Attribute {
  Attribute("srcLang", value)
}

/// What a `<track>` is for: `"subtitles"`, `"captions"`, `"chapters"` or
/// `"metadata"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/track#kind)
pub fn kind(value: String) -> Attribute {
  Attribute("kind", value)
}

/// Enables a `<track>` by default. `True` renders `default=""`; `False`
/// leaves it out.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/track#default)
pub fn default(value: Bool) -> Attribute {
  BoolAttribute("default", value)
}

/// A URL for the source of a quotation or change, on `<blockquote>`, `<q>`,
/// `<ins>` and `<del>`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/blockquote#cite)
pub fn cite(value: String) -> Attribute {
  Attribute("cite", value)
}

/// The coordinates of an `<area>` in an image map, comma-separated pixel
/// values whose meaning depends on `shape`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/area#coords)
pub fn coords(value: String) -> Attribute {
  Attribute("coords", value)
}

/// The shape of an `<area>`: `"rect"`, `"circle"`, `"poly"` or
/// `"default"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/area#shape)
pub fn shape(value: String) -> Attribute {
  Attribute("shape", value)
}

/// Blocks rendering until a `<script>`, `<link>` or `<style>` has loaded;
/// the only value is `"render"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/script#blocking)
pub fn blocking(value: String) -> Attribute {
  Attribute("blocking", value)
}

/// Whether translation tools should translate the element's text: `"yes"`
/// or `"no"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/translate)
pub fn translate(value: String) -> Attribute {
  Attribute("translate", value)
}

/// Whether assistive tech announces the whole live region on a change, not
/// just the changed part. Renders `"true"` or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-atomic)
pub fn aria_atomic(value: Bool) -> Attribute {
  BoolAttribute("aria-atomic", value)
}

/// Marks the element as being updated, so assistive tech waits before
/// announcing it. Renders `"true"` or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-busy)
pub fn aria_busy(value: Bool) -> Attribute {
  BoolAttribute("aria-busy", value)
}

/// Marks the element as perceivable but disabled. Unlike `disabled`, it
/// changes nothing but the accessibility tree. Renders `"true"` or
/// `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-disabled)
pub fn aria_disabled(value: Bool) -> Attribute {
  BoolAttribute("aria-disabled", value)
}

/// Whether the control's grouping element (menu, disclosure, tree item) is
/// expanded. Renders `"true"` or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-expanded)
pub fn aria_expanded(value: Bool) -> Attribute {
  BoolAttribute("aria-expanded", value)
}

/// Hides the element and its subtree from assistive tech. Renders
/// `"true"` or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-hidden)
pub fn aria_hidden(value: Bool) -> Attribute {
  BoolAttribute("aria-hidden", value)
}

/// Whether a dialog is modal. Renders `"true"` or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-modal)
pub fn aria_modal(value: Bool) -> Attribute {
  BoolAttribute("aria-modal", value)
}

/// Whether a text box accepts multiple lines. Renders `"true"` or
/// `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiline)
pub fn aria_multiline(value: Bool) -> Attribute {
  BoolAttribute("aria-multiline", value)
}

/// Whether more than one item can be selected in a listbox, grid or tree.
/// Renders `"true"` or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiselectable)
pub fn aria_multiselectable(value: Bool) -> Attribute {
  BoolAttribute("aria-multiselectable", value)
}

/// Whether the element is read-only but still operable. Renders `"true"`
/// or `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-readonly)
pub fn aria_readonly(value: Bool) -> Attribute {
  BoolAttribute("aria-readonly", value)
}

/// Whether user input is required before submitting. Renders `"true"` or
/// `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-required)
pub fn aria_required(value: Bool) -> Attribute {
  BoolAttribute("aria-required", value)
}

/// Whether a tab, option, row or cell is selected. Renders `"true"` or
/// `"false"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-selected)
pub fn aria_selected(value: Bool) -> Attribute {
  BoolAttribute("aria-selected", value)
}

/// The total number of columns in a table or grid, when not all are in
/// the DOM; `-1` if unknown.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colcount)
pub fn aria_colcount(value: Int) -> Attribute {
  IntAttribute("aria-colcount", value)
}

/// A cell's 1-based column index in a table or grid.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindex)
pub fn aria_colindex(value: Int) -> Attribute {
  IntAttribute("aria-colindex", value)
}

/// How many columns a cell spans in a table or grid.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colspan)
pub fn aria_colspan(value: Int) -> Attribute {
  IntAttribute("aria-colspan", value)
}

/// The hierarchical level of a heading, tree item or nested list item,
/// starting at 1.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-level)
pub fn aria_level(value: Int) -> Attribute {
  IntAttribute("aria-level", value)
}

/// An item's 1-based position in its set, when not all items are in the
/// DOM. Pair with `aria_setsize`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-posinset)
pub fn aria_posinset(value: Int) -> Attribute {
  IntAttribute("aria-posinset", value)
}

/// The total number of rows in a table or grid, when not all are in the
/// DOM; `-1` if unknown.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowcount)
pub fn aria_rowcount(value: Int) -> Attribute {
  IntAttribute("aria-rowcount", value)
}

/// A row or cell's 1-based row index in a table or grid.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindex)
pub fn aria_rowindex(value: Int) -> Attribute {
  IntAttribute("aria-rowindex", value)
}

/// How many rows a cell spans in a table or grid.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowspan)
pub fn aria_rowspan(value: Int) -> Attribute {
  IntAttribute("aria-rowspan", value)
}

/// The number of items in the current set, when not all are in the DOM;
/// `-1` if unknown. Pair with `aria_posinset`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-setsize)
pub fn aria_setsize(value: Int) -> Attribute {
  IntAttribute("aria-setsize", value)
}

/// The checked state of a checkbox, radio, switch or menu item: `"true"`,
/// `"false"` or `"mixed"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-checked)
pub fn aria_checked(value: String) -> Attribute {
  Attribute("aria-checked", value)
}

/// The pressed state of a toggle button: `"true"`, `"false"` or `"mixed"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-pressed)
pub fn aria_pressed(value: String) -> Attribute {
  Attribute("aria-pressed", value)
}

/// The maximum value of a range widget such as a slider, as a number.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemax)
pub fn aria_valuemax(value: String) -> Attribute {
  Attribute("aria-valuemax", value)
}

/// The minimum value of a range widget such as a slider, as a number.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemin)
pub fn aria_valuemin(value: String) -> Attribute {
  Attribute("aria-valuemin", value)
}

/// The current value of a range widget such as a slider, as a number.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuenow)
pub fn aria_valuenow(value: String) -> Attribute {
  Attribute("aria-valuenow", value)
}

/// A human-readable form of a range widget's value, like `"3 of 5 stars"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuetext)
pub fn aria_valuetext(value: String) -> Attribute {
  Attribute("aria-valuetext", value)
}

/// The `id` of the active descendant of a focused composite widget, like
/// the highlighted option in a combobox.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-activedescendant)
pub fn aria_activedescendant(value: String) -> Attribute {
  Attribute("aria-activedescendant", value)
}

/// How a combobox or text box offers completions: `"none"`, `"inline"`,
/// `"list"` or `"both"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-autocomplete)
pub fn aria_autocomplete(value: String) -> Attribute {
  Attribute("aria-autocomplete", value)
}

/// A label for braille displays, used instead of the accessible name.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-braillelabel)
pub fn aria_braillelabel(value: String) -> Attribute {
  Attribute("aria-braillelabel", value)
}

/// A role description for braille displays, used instead of
/// `aria-roledescription`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-brailleroledescription)
pub fn aria_brailleroledescription(value: String) -> Attribute {
  Attribute("aria-brailleroledescription", value)
}

/// A human-readable alternative to `aria-colindex`, like `"Column B"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindextext)
pub fn aria_colindextext(value: String) -> Attribute {
  Attribute("aria-colindextext", value)
}

/// Space-separated `id`s of the elements this one controls.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-controls)
pub fn aria_controls(value: String) -> Attribute {
  Attribute("aria-controls", value)
}

/// Marks the current item in a set: `"page"`, `"step"`, `"location"`,
/// `"date"`, `"time"`, `"true"` or `"false"`.
///
/// ```gleam
/// html.a([attribute.href("/docs"), attribute.aria_current("page")], [
///   html.text("Docs"),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-current)
pub fn aria_current(value: String) -> Attribute {
  Attribute("aria-current", value)
}

/// Space-separated `id`s of the elements that describe this one.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-describedby)
pub fn aria_describedby(value: String) -> Attribute {
  Attribute("aria-describedby", value)
}

/// A description of the element as a string, for when no visible element
/// holds it (otherwise use `aria_describedby`).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-description)
pub fn aria_description(value: String) -> Attribute {
  Attribute("aria-description", value)
}

/// Space-separated `id`s of elements with extended details about this one.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-details)
pub fn aria_details(value: String) -> Attribute {
  Attribute("aria-details", value)
}

/// The `id` of the element holding the error message for this one. Only
/// read when `aria-invalid` is set.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-errormessage)
pub fn aria_errormessage(value: String) -> Attribute {
  Attribute("aria-errormessage", value)
}

/// Space-separated `id`s of the next elements in an alternate reading
/// order.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-flowto)
pub fn aria_flowto(value: String) -> Attribute {
  Attribute("aria-flowto", value)
}

/// The kind of popup the element opens: `"false"`, `"true"`, `"menu"`,
/// `"listbox"`, `"tree"`, `"grid"` or `"dialog"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-haspopup)
pub fn aria_haspopup(value: String) -> Attribute {
  Attribute("aria-haspopup", value)
}

/// Whether the value fails validation: `"false"`, `"true"`, `"grammar"` or
/// `"spelling"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid)
pub fn aria_invalid(value: String) -> Attribute {
  Attribute("aria-invalid", value)
}

/// Keyboard shortcuts that activate or focus the element, space-separated,
/// like `"Control+S"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-keyshortcuts)
pub fn aria_keyshortcuts(value: String) -> Attribute {
  Attribute("aria-keyshortcuts", value)
}

/// The accessible name of the element, for when there is no visible label
/// (otherwise use `aria_labelledby`).
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-label)
pub fn aria_label(value: String) -> Attribute {
  Attribute("aria-label", value)
}

/// Space-separated `id`s of the elements that label this one.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-labelledby)
pub fn aria_labelledby(value: String) -> Attribute {
  Attribute("aria-labelledby", value)
}

/// Makes the element a live region whose updates are announced: `"off"`,
/// `"polite"` or `"assertive"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-live)
pub fn aria_live(value: String) -> Attribute {
  Attribute("aria-live", value)
}

/// The orientation of a slider, scrollbar, separator, listbox or similar:
/// `"horizontal"` or `"vertical"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-orientation)
pub fn aria_orientation(value: String) -> Attribute {
  Attribute("aria-orientation", value)
}

/// Space-separated `id`s of elements this one owns that aren't its DOM
/// children.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-owns)
pub fn aria_owns(value: String) -> Attribute {
  Attribute("aria-owns", value)
}

/// A hint for an empty text box or combobox. Use `placeholder` on native
/// inputs.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-placeholder)
pub fn aria_placeholder(value: String) -> Attribute {
  Attribute("aria-placeholder", value)
}

/// Which changes in a live region are announced: space-separated
/// `"additions"`, `"removals"` and `"text"`, or `"all"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-relevant)
pub fn aria_relevant(value: String) -> Attribute {
  Attribute("aria-relevant", value)
}

/// A human-readable description of the element's role, like `"slide"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-roledescription)
pub fn aria_roledescription(value: String) -> Attribute {
  Attribute("aria-roledescription", value)
}

/// A human-readable alternative to `aria-rowindex`, like `"Row 5"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindextext)
pub fn aria_rowindextext(value: String) -> Attribute {
  Attribute("aria-rowindextext", value)
}

/// The sort order of a table or grid column header: `"ascending"`,
/// `"descending"`, `"none"` or `"other"`.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-sort)
pub fn aria_sort(value: String) -> Attribute {
  Attribute("aria-sort", value)
}

/// React's reconciliation key, which tells siblings in a list apart so
/// React can keep their state when the list changes. Never rendered. Keys
/// must be unique among siblings.
///
/// ```gleam
/// html.ul([], {
///   use item <- list.map(items)
///   html.li([attribute.key(item.id)], [html.text(item.name)])
/// })
/// ```
///
/// [React reference](https://react.dev/learn/rendering-lists#keeping-list-items-in-order-with-key)
pub fn key(value: String) -> Attribute {
  Attribute("key", value)
}

/// CSS class names, keeping the ones whose flag is `True`, joined into one
/// `className`.
///
/// ```gleam
/// attribute.classes([#("button", True), #("active", is_active)])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Global_attributes/class)
pub fn classes(names: List(#(String, Bool))) -> Attribute {
  names
  |> list.filter_map(fn(pair) {
    case pair.1 {
      True -> Ok(pair.0)
      False -> Error(Nil)
    }
  })
  |> string.join(" ")
  |> class
}

/// Makes an `<a>` or `<area>` download its target instead of opening it.
/// The value is the suggested filename; `""` keeps the server's name.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a#download)
pub fn download(filename: String) -> Attribute {
  Attribute("download", filename)
}

/// URLs the browser POSTs to when an `<a>` or `<area>` is followed, for
/// tracking. Joined with spaces.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/a#ping)
pub fn ping(urls: List(String)) -> Attribute {
  Attribute("ping", string.join(urls, " "))
}

/// The file types a file `<input>` accepts, as extensions (`".pdf"`) or
/// MIME types (`"image/*"`). Joined with commas.
///
/// ```gleam
/// html.input([
///   attribute.type_("file"),
///   attribute.accept([".png", "image/jpeg"]),
/// ])
/// ```
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes/accept)
pub fn accept(types: List(String)) -> Attribute {
  Attribute("accept", string.join(types, ","))
}

/// The `id`s of the `<th>` cells that head a `<td>` or `<th>`, for complex
/// tables. Joined with spaces.
///
/// [MDN reference](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/td#headers)
pub fn headers(ids: List(String)) -> Attribute {
  Attribute("headers", string.join(ids, " "))
}
