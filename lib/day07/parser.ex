defmodule AoC2020.Day07.Parser do
  import NimbleParsec

  whitespace = ascii_string([?\s], min: 1)
  color = ascii_string([?a..?z], min: 1)
  modifier = ascii_string([?a..?z], min: 1)

  bag =
    unwrap_and_tag(modifier, :modifier)
    |> ignore(whitespace)
    |> unwrap_and_tag(color, :color)
    |> ignore(whitespace)
    |> ignore(string("bag") |> optional(string("s")))
    |> tag(:bag)

  bag_content =
    choice(
      [
        ignore(string("no other bags")),
        times(
          integer(min: 1)
          |> ignore(whitespace)
          |> concat(bag)
          |> wrap()
          |> map({List, :to_tuple, []})
          |> ignore(optional(ascii_char([?,]) |> concat(whitespace))),
          min: 0
        )
      ]
    )

  # Example: "light red bags contain 1 bright white bag, 2 muted yellow bags."
  rule =
    bag
    |> ignore(whitespace |> string("contain") |> concat(whitespace))
    |> concat(bag_content |> tag(:content))
    |> ignore(ascii_char([?.]))
    |> eos()

  defparsec :parse, rule
end
