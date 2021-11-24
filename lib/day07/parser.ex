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

  def bag_parser(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&to_bag/1)
    |> Map.new
  end

  defp to_bag({:ok, [bag: [modifier: mod, color: color], content: bags], _, _, _, _}) do
    content = bags |> Enum.map(&to_content/1) |> Map.new

    {{mod, color}, content}
  end

  defp to_content({amount, {:bag, [modifier: mod, color: color]}}) do
    {{mod, color}, amount}
  end
end
