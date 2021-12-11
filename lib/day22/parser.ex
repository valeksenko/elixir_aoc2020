defmodule AoC2020.Day22.Parser do
  import NimbleParsec

  new_line = ascii_string([?\n], 1)

  deck =
    ignore(string("Player ") |> concat(ascii_string([?1, ?2, ?:], 2)) |> ignore(new_line))
    |> repeat(integer(min: 1) |> ignore(optional(new_line)))

  decks =
    times(
      deck
      |> wrap
      |> ignore(optional(new_line)),
      2
    )
    |> eos()

  defparsec(:parse, decks)

  def deck_parser(data) do
    data
    |> parse
    |> to_decks
  end

  defp to_decks({:ok, decks, "", _, _, _}), do: List.to_tuple(decks)
end
