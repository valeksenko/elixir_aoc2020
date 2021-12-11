defmodule AoC2020.Day21.Parser do
  import NimbleParsec

  whitespace = ascii_string([?\s], min: 1)

  allergens =
    ignore(string("(contains "))
    |> repeat(
      ascii_string([?a..?z], min: 1)
      |> ignore(optional(string(", ")))
    )
    |> tag(:allergens)
    |> ignore(string(")"))

  ingridients =
    repeat(
      ascii_string([?a..?z], min: 1)
      |> ignore(optional(whitespace))
    )
    |> tag(:ingridients)

  defparsec(:parse, ingridients |> concat(allergens) |> eos())

  def list_parser(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&to_list/1)
  end

  defp to_list({:ok, [ingridients: ingridients, allergens: allergens], "", _, _, _}) do
    {ingridients, allergens}
  end
end
