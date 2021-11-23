defmodule AoC2020.Day03.Part1 do
  @behaviour AoC2020.Day

  @step 3

  @impl AoC2020.Day
  def run(data) do
    data |> count_trees
  end

  defp count_trees(map) do
    map |> Enum.reduce([], &move_tobogan/2) |> Enum.count(& &1)
  end

  defp move_tobogan(row, trees) do
    pos = Integer.mod(@step * length(trees), String.length(row))
    tree = Enum.at(String.graphemes(row), pos) == "#"

    [tree | trees]
  end
end
