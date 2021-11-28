defmodule AoC2020.Day12.Part1 do
  defmodule Navigation do
    @enforce_keys [:facing, :position]
    defstruct @enforce_keys
  end

  @north "N"
  @south "S"
  @east "E"
  @west "W"
  @left "L"
  @right "R"
  @forward "F"

  @start {0, 0}

  @rotations %{
    @north => 0,
    @east => 90,
    @south => 180,
    @west => 270
  }
  @degrees Map.new(for {k, v} <- @rotations, do: {v, k})

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&to_direction/1)
    |> Enum.reduce(%Navigation{facing: @east, position: @start}, &navigate/2)
    |> distance(@start)
  end

  defp navigate({dir, amount}, nav) do
    case dir do
      @north -> move(nav, {0, -1}, amount)
      @south -> move(nav, {0, 1}, amount)
      @east -> move(nav, {-1, 0}, amount)
      @west -> move(nav, {1, 0}, amount)
      @forward -> navigate({nav.facing, amount}, nav)
      @left -> turn(nav, 360 - amount)
      @right -> turn(nav, amount)
    end
  end

  defp move(%Navigation{facing: dir, position: {x1, y1}}, {x2, y2}, amount) do
    %Navigation{facing: dir, position: {x1 + x2 * amount, y1 + y2 * amount}}
  end

  defp turn(%Navigation{facing: dir, position: pos}, amount) do
    degree = (@rotations[dir] + amount) |> Integer.mod(360)
    %Navigation{facing: @degrees[degree], position: pos}
  end

  defp distance(%Navigation{position: {x1, y1}}, {x2, y2}) do
    abs(x1 + x2) + abs(y1 + y2)
  end

  defp to_direction(datum) do
    datum
    |> String.split_at(1)
    |> (fn {dir, num} -> {dir, String.to_integer(num)} end).()
  end
end
