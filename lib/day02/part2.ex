defmodule AoC2020.Day02.Part2 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data |> Enum.count(&valid_password?/1)
  end

  defp valid_password?(entry) do
    record = parse(entry)

    positions =
      record.password
      |> String.graphemes()
      |> Enum.with_index(1)
      |> Enum.filter(&(record.char == elem(&1, 0)))
      |> Enum.map(&elem(&1, 1))

    length(record.rule -- positions) == 1
  end

  defp parse(entry) do
    [rule_field, char, password] = String.split(entry, ~r/[ :]+/)
    %{rule: to_rule(rule_field), char: char, password: password}
  end

  defp to_rule(field) do
    field |> String.split("-") |> Enum.map(&String.to_integer/1)
  end
end
