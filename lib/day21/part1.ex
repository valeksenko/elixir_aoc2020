defmodule AoC2020.Day21.Part1 do
  import AoC2020.Day21.Parser

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> list_parser
    |> count_non_allergens
  end

  defp count_non_allergens(list) do
    all = Enum.flat_map(list, &elem(&1, 0))
    non_allergens = Enum.uniq(all) -- identify_allergens(list)

    Enum.count(all, &(&1 in non_allergens))
  end

  defp identify_allergens(list) do
    list
    |> Enum.reduce(%{}, &extract_allergens/2)
    |> Enum.flat_map(fn {_, i} -> extract(i) end)
    |> Enum.uniq()
  end

  defp extract(list) do
    list
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, num} -> num == length(list) end)
    |> Enum.map(&elem(&1, 0))
  end

  defp extract_allergens({ingridients, allergens}, map) do
    allergens
    |> Enum.reduce(map, fn a, m -> Map.put(m, a, [ingridients | Map.get(map, a, [])]) end)
  end
end
