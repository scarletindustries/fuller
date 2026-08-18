import fuller
import fuller/attribute
import fuller/element/html
import gleam/int
import gleam/io
import gleam/list

@external(erlang, "erlang", "monotonic_time")
fn now_ms(unit: MsUnit) -> Int

type MsUnit {
  Millisecond
}

fn row(i: Int) {
  html.tr([], [
    html.td([], [html.text("row " <> int.to_string(i))]),
    html.td([], [
      html.a([attribute.href("/x/" <> int.to_string(i))], [html.text("link")]),
    ]),
  ])
}

pub fn main() {
  let t0 = now_ms(Millisecond)
  let renderer = fuller.new()

  let t1 = now_ms(Millisecond)
  io.println("boot: " <> int.to_string(t1 - t0) <> " ms")
  let page = html.table([], [html.tbody([], list.map(list_range(0, 199), row))])
  let assert Ok(html) = fuller.render_to_string(renderer, page)

  let t2 = now_ms(Millisecond)
  io.println(
    "first render (200 rows, "
    <> int.to_string(string_size(html))
    <> " bytes): "
    <> int.to_string(t2 - t1)
    <> " ms",
  )

  let t3 = now_ms(Millisecond)
  list.each(list_range(1, 20), fn(_) {
    let assert Ok(_) = fuller.render_to_string(renderer, page)
  })

  let t4 = now_ms(Millisecond)
  io.println(
    "20 renders: "
    <> int.to_string(t4 - t3)
    <> " ms ("
    <> int.to_string({ t4 - t3 } / 20)
    <> " ms each)",
  )
}

@external(erlang, "erlang", "byte_size")
fn string_size(s: String) -> Int

fn list_range(from: Int, to: Int) -> List(Int) {
  case from > to {
    True -> []
    False -> [from, ..list_range(from + 1, to)]
  }
}
