defmodule AoC2020.Day21.Part2 do
  import AoC2020.Day21.Parser

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> list_parser
    |> identify_allergens
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
    |> Enum.join(",")
  end

  defp identify_allergens(list) do
    list
    |> Enum.reduce(%{}, &extract_allergens/2)
    |> Enum.map(fn {a, i} -> {a, extract(i)} end)
    |> Stream.iterate(&simplify/1)
    |> Stream.drop_while(fn l -> Enum.any?(l, &(length(elem(&1, 1)) > 1)) end)
    |> Enum.take(1)
    |> hd
  end

  def simplify(map) do
    identified =
      map |> Enum.filter(fn {_, i} -> length(i) == 1 end) |> Enum.flat_map(&elem(&1, 1))

    Enum.map(map, fn {a, i} -> if length(i) == 1, do: {a, i}, else: {a, i -- identified} end)
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
