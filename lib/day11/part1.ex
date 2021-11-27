defmodule AoC2020.Day11.Part1 do
  @behaviour AoC2020.Day

  @floor "."
  @free "L"
  @occupied "#"

  @impl AoC2020.Day
  def run(data) do
    data
    |> to_map()
    |> Stream.iterate(fn map -> Enum.reduce(map, {map, map}, &next/2) |> elem(1) end)
    |> Enum.reduce_while(Map.new(), fn map, prev ->
      if map == prev, do: {:halt, map}, else: {:cont, map}
    end)
    |> Enum.count(fn {_, v} -> v == @occupied end)
  end

  defp next({pos, val}, {old, new}) do
    updated =
      case val do
        @floor -> new
        @free -> if taken(old, pos) == 0, do: Map.put(new, pos, @occupied), else: new
        @occupied -> if taken(old, pos) > 3, do: Map.put(new, pos, @free), else: new
      end

    {old, updated}
  end

  defp taken(map, {x, y}) do
    neighbors()
    |> Enum.map(fn {xd, yd} -> Map.get(map, {x + xd, y + yd}) end)
    |> Enum.count(&(&1 == @occupied))
  end

  defp neighbors do
    for xd <- -1..1, yd <- -1..1, {xd, yd} != {0, 0}, do: {xd, yd}
  end

  defp to_map(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m -> Map.put(m, {x, y}, v) end)
  end

  defp inspect_map(map) do
    map
    |> Map.keys()
    |> Enum.sort()
    |> Enum.each(fn {x, y} ->
      if y == 0, do: IO.binwrite("\n")
      IO.binwrite(Map.get(map, {x, y}))
    end)

    IO.binwrite("\n\n")

    map
  end
end
