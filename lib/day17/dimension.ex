defmodule AoC2020.Day17.Dimension do
  def to_dimension(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m -> Map.put(m, {x, y, 0}, v) end)
  end

  def inspect_dimension(map) do
    map
    |> Map.keys()
    |> Enum.group_by(fn {_, _, z} -> z end)
    |> Map.to_list()
    |> Enum.sort()
    |> Enum.each(fn {z, pos} ->
      IO.binwrite("z=#{z}:\n")
      inspect_plane(map, pos)
    end)

    IO.binwrite("=============\n\n")

    map
  end

  def inspect_plane(map, positions) do
    positions
    |> Enum.sort_by(fn {x, y, _} -> {y, x} end)
    |> Enum.each(fn pos = {x, _, _} ->
      if x == 0, do: IO.binwrite("\n")
      IO.binwrite(Map.get(map, pos))
    end)

    IO.binwrite("\n\n")
  end
end
