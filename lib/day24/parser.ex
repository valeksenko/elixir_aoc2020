defmodule AoC2020.Day24.Parser do
  import NimbleParsec

  directions =
    times(
      choice([
        string("sw"),
        string("nw"),
        string("se"),
        string("ne"),
        string("s"),
        string("n"),
        string("e"),
        string("w")
      ]),
      min: 1
    )
    |> eos()

  defparsec(:parse, directions)

  def parse_directions(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&to_directions/1)
  end

  defp to_directions({:ok, directions, "", _, _, _}), do: directions
end
