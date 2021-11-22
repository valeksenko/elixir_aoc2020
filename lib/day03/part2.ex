defmodule AoC2020.Day03.Part2 do
  @behaviour AoC2020.Day

  @slops [ { 1, 1 }, { 3, 1 }, { 5, 1 }, { 7, 1 }, { 1, 2 } ]

  @impl AoC2020.Day
  def run(data) do
    @slops |> Enum.map(&(count_trees(data, &1))) |> Enum.product
  end

  defp count_trees(map, { right, down }) do
    map |> Enum.take_every(down) |> Enum.reduce([], &(move_tobogan(&1, &2, right))) |> Enum.count(&(&1))
  end

  defp move_tobogan(row, trees, step) do
    pos = Integer.mod(step * length(trees), String.length(row))
    tree = Enum.at(String.graphemes(row), pos) == "#"

    [ tree | trees ]
  end
end
