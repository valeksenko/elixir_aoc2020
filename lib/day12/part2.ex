defmodule AoC2020.Day12.Part2 do
  defmodule Navigation do
    @enforce_keys [:ship, :waypoint]
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

  @movement %{
    @north => {1, 0},
    @east => {0, 1},
    @south => {-1, 0},
    @west => {0, -1}
  }

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&to_direction/1)
    |> Enum.reduce(%Navigation{ship: @start, waypoint: {1, 10}}, &navigate/2)
    |> distance(@start)
  end

  defp navigate({dir, amount}, nav) do
    case dir do
      @forward -> move_ship(nav, amount)
      @left -> turn_waypoint(nav, 360 - amount)
      @right -> turn_waypoint(nav, amount)
      _ -> move_waypoint(nav, @movement[dir], amount)
    end
  end

  defp move_ship(nav = %Navigation{ship: {x1, y1}, waypoint: {x2, y2}}, amount) do
    %{nav | ship: {x1 + x2 * amount, y1 + y2 * amount}}
  end

  defp move_waypoint(nav = %Navigation{waypoint: {x1, y1}}, {x2, y2}, amount) do
    %{nav | waypoint: {x1 + x2 * amount, y1 + y2 * amount}}
  end

  defp turn_waypoint(nav = %Navigation{waypoint: {x, y}}, degree) do
    pos =
      case degree do
        90 -> {-y, x}
        180 -> {-x, -y}
        270 -> {y, -x}
      end

    %{nav | waypoint: pos}
  end

  defp distance(%Navigation{ship: {x1, y1}}, {x2, y2}) do
    abs(x1 + x2) + abs(y1 + y2)
  end

  defp to_direction(datum) do
    datum
    |> String.split_at(1)
    |> (fn {dir, num} -> {dir, String.to_integer(num)} end).()
  end
end
