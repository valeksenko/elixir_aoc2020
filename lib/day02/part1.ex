defmodule AoC2020.Day02.Part1 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data |> Enum.count(&valid_password?/1)
  end

  defp valid_password?(entry) do
    record = parse(entry)
    count = record.password |> String.graphemes() |> Enum.count(&(record.char == &1))

    count in record.rule
  end

  defp parse(entry) do
    [rule_field, char, password] = String.split(entry, ~r/[ :]+/)
    %{rule: to_rule(rule_field), char: char, password: password}
  end

  defp to_rule(field) do
    field
    |> String.split("-")
    |> (fn [first, last] -> String.to_integer(first)..String.to_integer(last) end).()
  end
end
