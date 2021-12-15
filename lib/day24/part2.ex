defmodule AoC2020.Day24.Part2 do
  import AoC2020.Day24.Parser

  alias __MODULE__, as: State

  defstruct [:tiles, :limits]

  @behaviour AoC2020.Day

  @days 10
  @white 0
  @black 1

  @impl AoC2020.Day
  def run(data) do
    data
    |> parse_directions
    |> Enum.reduce(%{}, &move_and_flip/2)
    |> to_state
    |> flip_tiles(0)
    |> Enum.count(fn {_, v} -> black?(v) end)
  end

  defp to_state(tiles) do
    %State{
      tiles: tiles,
      limits:
        0..2
        |> Enum.map(fn i -> tiles |> Map.keys() |> Enum.map(&elem(&1, i)) |> Enum.min_max() end)
    }
  end

  defp flip_tiles(state, @days), do: state.tiles

  defp flip_tiles(state, day) do
    new = %{
      state
      | tiles:
          positions(state.limits, day)
          |> Enum.reduce(%{}, fn p, t -> Map.put(t, p, tile_color(p, state.tiles)) end)
    }

    flip_tiles(new, day + 1)
  end

  defp tile_color(pos, tiles) do
    case Map.get(tiles, pos, @white) do
      @white -> if black_count(pos, tiles) == 2, do: @black, else: @white
      @black -> if black_count(pos, tiles) in 1..2, do: @black, else: @white
    end
  end

  defp black_count({x, y, z}, tiles) do
    [{1, -1, 0}, {1, 0, -1}, {0, 1, -1}, {-1, 1, 0}, {-1, 0, 1}, {0, -1, 1}]
    |> Enum.count(fn {xd, yd, zd} ->
      tiles |> Map.get({x + xd, y + yd, z + zd}, @white) |> black?
    end)
  end

  defp positions([{x1, x2}, {y1, y2}, {z1, z2}], day) do
    for x <- (x1 - day - 1)..(x2 + day + 1),
        y <- (y1 - day - 1)..(y2 + day + 1),
        z <- (z1 - day - 1)..(z2 + day + 1),
        do: {x, y, z}
  end

  defp move_and_flip(directions, tiles) do
    directions
    |> Enum.reduce({0, 0, 0}, &move/2)
    |> flip(tiles)
  end

  defp black?(num) do
    rem(num, 2) == @black
  end

  defp flip(pos, tiles) do
    tiles
    |> Map.put(pos, rem(1 + Map.get(tiles, pos, 0), 2))
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
