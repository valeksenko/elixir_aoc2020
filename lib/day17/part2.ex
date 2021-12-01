defmodule AoC2020.Day17.Part2 do
  import AoC2020.Day17.Dimension

  @behaviour AoC2020.Day

  @active "#"
  @inactive "."

  @cycles 6
  @dimensions 4

  @impl AoC2020.Day
  def run(data) do
    data
    |> to_dimension(@dimensions)
    |> add_neighbors()
    |> Stream.iterate(fn map ->
      Enum.reduce(map |> add_neighbors(), {map, Map.new()}, &next/2) |> elem(1)
    end)
    |> Stream.drop(@cycles)
    |> Enum.take(1)
    |> hd
    |> Enum.count(fn {_, v} -> v == @active end)
  end

  defp next({pos, val}, {old, new}) do
    updated =
      case val do
        @active -> if active(old, pos) in 2..3, do: @active, else: @inactive
        @inactive -> if active(old, pos) == 3, do: @active, else: @inactive
      end

    {old, Map.put(new, pos, updated)}
  end

  defp add_neighbors(map) do
    0..(@dimensions - 1)
    |> Enum.reduce(map, &add_neighbors_for_index/2)
  end

  defp add_neighbors_for_index(index, map) do
    {min, max} =
      map
      |> Map.keys()
      |> Enum.min_max_by(&elem(&1, index))

    map
    |> add_layer(index, elem(min, index), -1)
    |> add_layer(index, elem(max, index), 1)
  end

  def add_layer(map, index, value, diff) do
    map
    |> Map.keys()
    |> Enum.filter(fn pos -> elem(pos, index) == value end)
    |> Enum.reduce(map, fn pos, layer ->
      layer |> Map.put(put_elem(pos, index, value + diff), @inactive)
    end)
  end

  defp active(map, {x, y, z, d}) do
    neighbors()
    |> Enum.map(fn {xd, yd, zd, dd} -> Map.get(map, {x + xd, y + yd, z + zd, d + dd}) end)
    |> Enum.count(&(&1 == @active))
  end

  defp neighbors do
    for xd <- -1..1, yd <- -1..1, zd <- -1..1, dd <- -1..1, {xd, yd, zd, dd} != {0, 0, 0, 0}, do: {xd, yd, zd, dd}
  end
end
