defmodule AoC2020.Day07.Part2 do
  import AoC2020.Day07.Parser

  @bag {"shiny", "gold"}

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    rules = data |> bag_parser

    collect(rules, rules[@bag], 0)
  end

  defp collect(rules, content, total) do
    count =
      content
      |> Enum.map(fn {bag, amount} -> amount * collect(rules, rules[bag], 1) end)
      |> Enum.sum()

    total + count
  end
end
