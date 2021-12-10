defmodule AoC2020.Day20.Parser do
  import NimbleParsec

  @size 10

  new_line = ascii_string([?\n], 1)

  tile =
    ignore(string("Tile "))
    |> concat(integer(min: 1))
    |> tag(:id)
    |> ignore(string(":") |> concat(new_line))
    |> times(
      ascii_string([?., ?#], @size)
      |> ignore(optional(new_line)),
      @size
    )

  tiles =
    repeat(
      tile
      |> tag(:tile)
      |> ignore(optional(new_line))
    )
    |> eos()

  defparsec(:parse, tiles)

  def tile_parser(data) do
    data
    |> parse
    |> to_tiles
  end

  defp to_tiles({:ok, tiles, "", _, _, _}) do
    tiles
    |> Enum.reduce(Map.new(), &add_tile/2)
  end

  defp add_tile({:tile, [{:id, [id]} | rows]}, map) do
    map
    |> Map.put(id, rows |> Enum.map(&String.graphemes/1))
  end
end
