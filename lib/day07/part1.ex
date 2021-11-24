defmodule AoC2020.Day07.Part1 do
  import AoC2020.Day07.Parser

  @bag {"shiny", "gold"}

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> bag_parser
    |> count
  end

  defp count(rules) do
    rules
    |> Map.delete(@bag)
    |> Enum.count(fn {bag, content} -> contain?(rules, bag, [], content |> Map.keys) end)
  end

  defp contain?(rules, bag, checked, bags) do
    cond do
      bag == @bag -> true
      Enum.member?(checked, bag) -> false
      true -> Enum.any?(bags, &(contain?(rules, &1, [bag | checked], rules[&1] |> Map.keys)))
    end
  end
end
