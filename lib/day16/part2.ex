defmodule AoC2020.Day16.Part2 do
  import AoC2020.Day16.Parser

  @behaviour AoC2020.Day

  @departure "departure "

  @impl AoC2020.Day
  def run(data) do
    {rules, mine, others} = notes_parser(data)

    [mine | others |> select_valid(rules)]
    |> map_indexes(rules)
    |> map_fields
    |> Enum.filter(fn {field, _} -> String.starts_with?(field, @departure) end)
    |> Enum.map(fn {_, ind} -> Enum.at(mine, ind) end)
    |> Enum.product()
  end

  defp map_fields(fields) do
    fields
    |> Enum.sort_by(&(elem(&1, 1) |> length))
    |> Enum.reduce([], fn {field, indexes}, fields ->
      [{field, field_index(fields, indexes)} | fields]
    end)
  end

  defp field_index(fields, indexes) do
    case indexes -- Enum.map(fields, &elem(&1, 1)) do
      [ind] -> ind
    end
  end

  defp map_indexes(tickets, rules) do
    rules
    |> Enum.reduce([], fn {field, ranges}, fields ->
      [{field, field_indexes(tickets, ranges)} | fields]
    end)
  end

  defp field_indexes(tickets, ranges) do
    fields = tickets |> hd |> length

    0..(fields - 1)
    |> Enum.filter(fn ind ->
      Enum.map(tickets, &Enum.at(&1, ind)) |> Enum.all?(&match_range?(&1, ranges))
    end)
  end

  defp match_range?(ind, ranges) do
    ranges
    |> Enum.any?(&(ind in &1))
  end

  defp select_valid(tickets, rules) do
    tickets
    |> Enum.filter(&valid_ticket?(rules, &1))
  end

  defp valid_ticket?(rules, ticket) do
    ticket
    |> Enum.all?(&valid?(rules, &1))
  end

  defp valid?(rules, value) do
    rules
    |> Map.values()
    |> List.flatten()
    |> Enum.any?(&(value in &1))
  end
end
