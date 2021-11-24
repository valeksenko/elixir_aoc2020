defmodule AoC2020.Day07.Part1 do
  import AoC2020.Day07.Parser

  @bag {"shiny", "gold"}

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&to_bag/1)
    |> Map.new
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

  defp to_bag({:ok, [bag: [modifier: mod, color: color], content: bags], _, _, _, _}) do
    content = bags |> Enum.map(&to_content/1) |> Map.new

    {{mod, color}, content}
  end

  defp to_content({amount, {:bag, [modifier: mod, color: color]}}) do
    {{mod, color}, amount}
  end
end
