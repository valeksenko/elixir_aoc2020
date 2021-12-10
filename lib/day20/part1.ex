defmodule AoC2020.Day20.Part1 do
  import AoC2020.Day20.Parser

  @size 10

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    tile_parser(data)
    |> Map.to_list()
    |> result
  end

  defp result(tiles) do
    tiles
    |> Enum.filter(fn tile -> Enum.count(tiles, &neighbors?(tile, &1)) == 2 end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.product()
  end

  defp neighbors?({_, tile1}, {_, tile2}) do
    tile1 != tile2 && length(edges(tile1) -- edges(tile2)) < 8
  end

  defp edges(tile) do
    main = [
      hd(tile),
      Enum.at(tile, @size - 1),
      Enum.map(tile, &Enum.at(&1, 0)),
      Enum.map(tile, &Enum.at(&1, @size - 1))
    ]

    main ++ Enum.map(main, &Enum.reverse/1)
  end
end
