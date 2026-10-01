//// Props. Function names follow HTML (`readonly`, `tabindex`, `for`); the
//// props they set are React's (`readOnly`, `tabIndex`, `htmlFor`).

import gleam/list
import gleam/string

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

pub fn accesskey(value: String) -> Attribute {
  Attribute("accessKey", value)
}

pub fn autocapitalize(value: String) -> Attribute {
  Attribute("autoCapitalize", value)
}

pub fn autofocus(value: Bool) -> Attribute {
  BoolAttribute("autoFocus", value)
}

pub fn contenteditable(value: String) -> Attribute {
  Attribute("contentEditable", value)
}

pub fn dir(value: String) -> Attribute {
  Attribute("dir", value)
}

pub fn draggable(value: Bool) -> Attribute {
  BoolAttribute("draggable", value)
}

pub fn enterkeyhint(value: String) -> Attribute {
  Attribute("enterKeyHint", value)
}

pub fn inert(value: Bool) -> Attribute {
  BoolAttribute("inert", value)
}

pub fn inputmode(value: String) -> Attribute {
  Attribute("inputMode", value)
}

pub fn is(value: String) -> Attribute {
  Attribute("is", value)
}

pub fn itemid(value: String) -> Attribute {
  Attribute("itemID", value)
}

pub fn itemprop(value: String) -> Attribute {
  Attribute("itemProp", value)
}

pub fn itemscope(value: Bool) -> Attribute {
  BoolAttribute("itemScope", value)
}

pub fn itemtype(value: String) -> Attribute {
  Attribute("itemType", value)
}

pub fn nonce(value: String) -> Attribute {
  Attribute("nonce", value)
}

pub fn popover(value: String) -> Attribute {
  Attribute("popover", value)
}

pub fn spellcheck(value: Bool) -> Attribute {
  BoolAttribute("spellCheck", value)
}

pub fn tabindex(value: Int) -> Attribute {
  IntAttribute("tabIndex", value)
}

pub fn open(value: Bool) -> Attribute {
  BoolAttribute("open", value)
}

pub fn hreflang(value: String) -> Attribute {
  Attribute("hrefLang", value)
}

pub fn referrerpolicy(value: String) -> Attribute {
  Attribute("referrerPolicy", value)
}

pub fn as_(value: String) -> Attribute {
  Attribute("as", value)
}

pub fn integrity(value: String) -> Attribute {
  Attribute("integrity", value)
}

pub fn srcset(value: String) -> Attribute {
  Attribute("srcSet", value)
}

pub fn sizes(value: String) -> Attribute {
  Attribute("sizes", value)
}

pub fn crossorigin(value: String) -> Attribute {
  Attribute("crossOrigin", value)
}

pub fn usemap(value: String) -> Attribute {
  Attribute("useMap", value)
}

pub fn ismap(value: Bool) -> Attribute {
  BoolAttribute("isMap", value)
}

pub fn decoding(value: String) -> Attribute {
  Attribute("decoding", value)
}

pub fn loading(value: String) -> Attribute {
  Attribute("loading", value)
}

pub fn fetchpriority(value: String) -> Attribute {
  Attribute("fetchPriority", value)
}

pub fn accept_charset(value: String) -> Attribute {
  Attribute("acceptCharset", value)
}

pub fn action(value: String) -> Attribute {
  Attribute("action", value)
}

pub fn enctype(value: String) -> Attribute {
  Attribute("encType", value)
}

pub fn method(value: String) -> Attribute {
  Attribute("method", value)
}

pub fn novalidate(value: Bool) -> Attribute {
  BoolAttribute("noValidate", value)
}

pub fn autocomplete(value: String) -> Attribute {
  Attribute("autoComplete", value)
}

pub fn default_checked(value: Bool) -> Attribute {
  BoolAttribute("defaultChecked", value)
}

pub fn cols(value: Int) -> Attribute {
  IntAttribute("cols", value)
}

pub fn dirname(value: String) -> Attribute {
  Attribute("dirName", value)
}

pub fn form(value: String) -> Attribute {
  Attribute("form", value)
}

pub fn formaction(value: String) -> Attribute {
  Attribute("formAction", value)
}

pub fn formenctype(value: String) -> Attribute {
  Attribute("formEncType", value)
}

pub fn formmethod(value: String) -> Attribute {
  Attribute("formMethod", value)
}

pub fn formnovalidate(value: Bool) -> Attribute {
  BoolAttribute("formNoValidate", value)
}

pub fn formtarget(value: String) -> Attribute {
  Attribute("formTarget", value)
}

pub fn list(value: String) -> Attribute {
  Attribute("list", value)
}

pub fn max(value: String) -> Attribute {
  Attribute("max", value)
}

pub fn maxlength(value: Int) -> Attribute {
  IntAttribute("maxLength", value)
}

pub fn min(value: String) -> Attribute {
  Attribute("min", value)
}

pub fn minlength(value: Int) -> Attribute {
  IntAttribute("minLength", value)
}

pub fn multiple(value: Bool) -> Attribute {
  BoolAttribute("multiple", value)
}

pub fn pattern(value: String) -> Attribute {
  Attribute("pattern", value)
}

pub fn popovertarget(value: String) -> Attribute {
  Attribute("popoverTarget", value)
}

pub fn popovertargetaction(value: String) -> Attribute {
  Attribute("popoverTargetAction", value)
}

pub fn readonly(value: Bool) -> Attribute {
  BoolAttribute("readOnly", value)
}

pub fn required(value: Bool) -> Attribute {
  BoolAttribute("required", value)
}

pub fn rows(value: Int) -> Attribute {
  IntAttribute("rows", value)
}

pub fn selected(value: Bool) -> Attribute {
  BoolAttribute("selected", value)
}

pub fn size(value: Int) -> Attribute {
  IntAttribute("size", value)
}

pub fn step(value: String) -> Attribute {
  Attribute("step", value)
}

pub fn default_value(value: String) -> Attribute {
  Attribute("defaultValue", value)
}

pub fn http_equiv(value: String) -> Attribute {
  Attribute("httpEquiv", value)
}

pub fn content(value: String) -> Attribute {
  Attribute("content", value)
}

pub fn charset(value: String) -> Attribute {
  Attribute("charSet", value)
}

pub fn media(value: String) -> Attribute {
  Attribute("media", value)
}

pub fn autoplay(value: Bool) -> Attribute {
  BoolAttribute("autoPlay", value)
}

pub fn controls(value: Bool) -> Attribute {
  BoolAttribute("controls", value)
}

pub fn loop(value: Bool) -> Attribute {
  BoolAttribute("loop", value)
}

pub fn muted(value: Bool) -> Attribute {
  BoolAttribute("muted", value)
}

pub fn playsinline(value: Bool) -> Attribute {
  BoolAttribute("playsInline", value)
}

pub fn poster(value: String) -> Attribute {
  Attribute("poster", value)
}

pub fn preload(value: String) -> Attribute {
  Attribute("preload", value)
}

pub fn abbr(value: String) -> Attribute {
  Attribute("abbr", value)
}

pub fn colspan(value: Int) -> Attribute {
  IntAttribute("colSpan", value)
}

pub fn rowspan(value: Int) -> Attribute {
  IntAttribute("rowSpan", value)
}

pub fn span(value: Int) -> Attribute {
  IntAttribute("span", value)
}

pub fn scope(value: String) -> Attribute {
  Attribute("scope", value)
}

pub fn datetime(value: String) -> Attribute {
  Attribute("dateTime", value)
}

pub fn async(value: Bool) -> Attribute {
  BoolAttribute("async", value)
}

pub fn defer(value: Bool) -> Attribute {
  BoolAttribute("defer", value)
}

pub fn nomodule(value: Bool) -> Attribute {
  BoolAttribute("noModule", value)
}

pub fn reversed(value: Bool) -> Attribute {
  BoolAttribute("reversed", value)
}

pub fn start(value: Int) -> Attribute {
  IntAttribute("start", value)
}

pub fn label(value: String) -> Attribute {
  Attribute("label", value)
}

pub fn high(value: String) -> Attribute {
  Attribute("high", value)
}

pub fn low(value: String) -> Attribute {
  Attribute("low", value)
}

pub fn optimum(value: String) -> Attribute {
  Attribute("optimum", value)
}

pub fn wrap(value: String) -> Attribute {
  Attribute("wrap", value)
}

pub fn srcdoc(value: String) -> Attribute {
  Attribute("srcDoc", value)
}

pub fn sandbox(value: String) -> Attribute {
  Attribute("sandbox", value)
}

pub fn allow(value: String) -> Attribute {
  Attribute("allow", value)
}

pub fn allowfullscreen(value: Bool) -> Attribute {
  BoolAttribute("allowFullScreen", value)
}

pub fn srclang(value: String) -> Attribute {
  Attribute("srcLang", value)
}

pub fn kind(value: String) -> Attribute {
  Attribute("kind", value)
}

pub fn default(value: Bool) -> Attribute {
  BoolAttribute("default", value)
}

pub fn cite(value: String) -> Attribute {
  Attribute("cite", value)
}

pub fn coords(value: String) -> Attribute {
  Attribute("coords", value)
}

pub fn shape(value: String) -> Attribute {
  Attribute("shape", value)
}

pub fn blocking(value: String) -> Attribute {
  Attribute("blocking", value)
}

pub fn translate(value: String) -> Attribute {
  Attribute("translate", value)
}

pub fn aria_atomic(value: Bool) -> Attribute {
  BoolAttribute("aria-atomic", value)
}

pub fn aria_busy(value: Bool) -> Attribute {
  BoolAttribute("aria-busy", value)
}

pub fn aria_disabled(value: Bool) -> Attribute {
  BoolAttribute("aria-disabled", value)
}

pub fn aria_expanded(value: Bool) -> Attribute {
  BoolAttribute("aria-expanded", value)
}

pub fn aria_hidden(value: Bool) -> Attribute {
  BoolAttribute("aria-hidden", value)
}

pub fn aria_modal(value: Bool) -> Attribute {
  BoolAttribute("aria-modal", value)
}

pub fn aria_multiline(value: Bool) -> Attribute {
  BoolAttribute("aria-multiline", value)
}

pub fn aria_multiselectable(value: Bool) -> Attribute {
  BoolAttribute("aria-multiselectable", value)
}

pub fn aria_readonly(value: Bool) -> Attribute {
  BoolAttribute("aria-readonly", value)
}

pub fn aria_required(value: Bool) -> Attribute {
  BoolAttribute("aria-required", value)
}

pub fn aria_selected(value: Bool) -> Attribute {
  BoolAttribute("aria-selected", value)
}

pub fn aria_colcount(value: Int) -> Attribute {
  IntAttribute("aria-colcount", value)
}

pub fn aria_colindex(value: Int) -> Attribute {
  IntAttribute("aria-colindex", value)
}

pub fn aria_colspan(value: Int) -> Attribute {
  IntAttribute("aria-colspan", value)
}

pub fn aria_level(value: Int) -> Attribute {
  IntAttribute("aria-level", value)
}

pub fn aria_posinset(value: Int) -> Attribute {
  IntAttribute("aria-posinset", value)
}

pub fn aria_rowcount(value: Int) -> Attribute {
  IntAttribute("aria-rowcount", value)
}

pub fn aria_rowindex(value: Int) -> Attribute {
  IntAttribute("aria-rowindex", value)
}

pub fn aria_rowspan(value: Int) -> Attribute {
  IntAttribute("aria-rowspan", value)
}

pub fn aria_setsize(value: Int) -> Attribute {
  IntAttribute("aria-setsize", value)
}

pub fn aria_checked(value: String) -> Attribute {
  Attribute("aria-checked", value)
}

pub fn aria_pressed(value: String) -> Attribute {
  Attribute("aria-pressed", value)
}

pub fn aria_valuemax(value: String) -> Attribute {
  Attribute("aria-valuemax", value)
}

pub fn aria_valuemin(value: String) -> Attribute {
  Attribute("aria-valuemin", value)
}

pub fn aria_valuenow(value: String) -> Attribute {
  Attribute("aria-valuenow", value)
}

pub fn aria_valuetext(value: String) -> Attribute {
  Attribute("aria-valuetext", value)
}

pub fn aria_activedescendant(value: String) -> Attribute {
  Attribute("aria-activedescendant", value)
}

pub fn aria_autocomplete(value: String) -> Attribute {
  Attribute("aria-autocomplete", value)
}

pub fn aria_braillelabel(value: String) -> Attribute {
  Attribute("aria-braillelabel", value)
}

pub fn aria_brailleroledescription(value: String) -> Attribute {
  Attribute("aria-brailleroledescription", value)
}

pub fn aria_colindextext(value: String) -> Attribute {
  Attribute("aria-colindextext", value)
}

pub fn aria_controls(value: String) -> Attribute {
  Attribute("aria-controls", value)
}

pub fn aria_current(value: String) -> Attribute {
  Attribute("aria-current", value)
}

pub fn aria_describedby(value: String) -> Attribute {
  Attribute("aria-describedby", value)
}

pub fn aria_description(value: String) -> Attribute {
  Attribute("aria-description", value)
}

pub fn aria_details(value: String) -> Attribute {
  Attribute("aria-details", value)
}

pub fn aria_errormessage(value: String) -> Attribute {
  Attribute("aria-errormessage", value)
}

pub fn aria_flowto(value: String) -> Attribute {
  Attribute("aria-flowto", value)
}

pub fn aria_haspopup(value: String) -> Attribute {
  Attribute("aria-haspopup", value)
}

pub fn aria_invalid(value: String) -> Attribute {
  Attribute("aria-invalid", value)
}

pub fn aria_keyshortcuts(value: String) -> Attribute {
  Attribute("aria-keyshortcuts", value)
}

pub fn aria_label(value: String) -> Attribute {
  Attribute("aria-label", value)
}

pub fn aria_labelledby(value: String) -> Attribute {
  Attribute("aria-labelledby", value)
}

pub fn aria_live(value: String) -> Attribute {
  Attribute("aria-live", value)
}

pub fn aria_orientation(value: String) -> Attribute {
  Attribute("aria-orientation", value)
}

pub fn aria_owns(value: String) -> Attribute {
  Attribute("aria-owns", value)
}

pub fn aria_placeholder(value: String) -> Attribute {
  Attribute("aria-placeholder", value)
}

pub fn aria_relevant(value: String) -> Attribute {
  Attribute("aria-relevant", value)
}

pub fn aria_roledescription(value: String) -> Attribute {
  Attribute("aria-roledescription", value)
}

pub fn aria_rowindextext(value: String) -> Attribute {
  Attribute("aria-rowindextext", value)
}

pub fn aria_sort(value: String) -> Attribute {
  Attribute("aria-sort", value)
}

/// React's `key`, for telling siblings in a list apart. Not rendered.
pub fn key(value: String) -> Attribute {
  Attribute("key", value)
}

/// The names whose flag is `True`, joined into one `className`.
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

pub fn download(filename: String) -> Attribute {
  Attribute("download", filename)
}

pub fn ping(urls: List(String)) -> Attribute {
  Attribute("ping", string.join(urls, " "))
}

pub fn accept(types: List(String)) -> Attribute {
  Attribute("accept", string.join(types, ","))
}

pub fn headers(ids: List(String)) -> Attribute {
  Attribute("headers", string.join(ids, " "))
}
