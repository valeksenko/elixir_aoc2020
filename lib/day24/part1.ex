defmodule AoC2020.Day24.Part1 do
  import AoC2020.Day24.Parser

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> parse_directions
    |> Enum.reduce(%{}, &flip_tile/2)
    |> Enum.count(fn {_, v} -> rem(v, 2) == 1 end)
  end

  defp flip_tile(directions, map) do
    directions
    |> Enum.reduce({0, 0, 0}, &move/2)
    |> (fn pos -> Map.put(map, pos, 1 + Map.get(map, pos, 0)) end).()
  end

  # https://www.redblobgames.com/grids/hexagons/#neighbors
  defp move(direction, {x, y, z}) do
    case direction do
      "e" -> {x + 1, y - 1, z}
      "se" -> {x, y - 1, z + 1}
      "sw" -> {x - 1, y, z + 1}
      "w" -> {x - 1, y + 1, z}
      "nw" -> {x, y + 1, z - 1}
      "ne" -> {x + 1, y, z - 1}
    end
  end
end
