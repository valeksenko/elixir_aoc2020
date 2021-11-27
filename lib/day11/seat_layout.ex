defmodule AoC2020.Day11.SeatLayout do
  def to_layout(data) do
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

  def inspect_layout(map) do
    map
    |> Map.keys()
    |> Enum.sort_by(fn {x, y} -> {y, x} end)
    |> Enum.each(fn {x, y} ->
      if x == 0, do: IO.binwrite("\n")
      IO.binwrite(Map.get(map, {x, y}))
    end)

    IO.binwrite("\n\n")

    map
  end
end
