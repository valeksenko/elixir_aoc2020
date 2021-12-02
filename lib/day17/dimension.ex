defmodule AoC2020.Day17.Dimension do
  def to_dimension(data, total) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row(&1, &2, total))
  end

  defp add_row({row, y}, map, total) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m ->
      Map.put(m, 3..total |> Enum.reduce({x, y}, &add_tuple/2), v)
    end)
  end

  defp add_tuple(_, tuple) do
    tuple |> Tuple.append(0)
  end
end
