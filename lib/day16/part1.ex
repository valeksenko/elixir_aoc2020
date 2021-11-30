defmodule AoC2020.Day16.Part1 do
  import AoC2020.Day16.Parser

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> notes_parser
    |> select_invalid
    |> Enum.sum()
  end

  defp select_invalid({rules, _, tickets}) do
    tickets
    |> Enum.flat_map(&invalid(rules, &1))
  end

  defp invalid(rules, ticket) do
    ticket
    |> Enum.filter(&(not valid?(rules, &1)))
  end

  defp valid?(rules, value) do
    rules
    |> Map.values()
    |> List.flatten()
    |> Enum.any?(&(value in &1))
  end
end
