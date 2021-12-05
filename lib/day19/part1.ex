defmodule AoC2020.Day19.Part1 do
  import AoC2020.Day19.Parser

  @initial 0

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    {ruleset, inputs} = rule_parser(data)

    inputs
    |> Enum.count(&valid?(&1, ruleset))
  end

  defp valid?(input, ruleset) do
    input
    |> String.graphemes()
    |> match_rules(ruleset, Map.fetch!(ruleset, @initial))
    |> (fn res -> {:ok, []} == res end).()
  end

  defp match_rule([], _, _), do: :miss

  defp match_rule([char | message], _, {:match, [match]}) do
    if char == match, do: {:ok, message}, else: :miss
  end

  defp match_rule(message, ruleset, {:rule, definitions}) do
    definitions
    |> Enum.reduce_while(message, &match_all(&2, ruleset, Map.fetch!(ruleset, &1)))
    |> (fn res -> if res == :miss, do: :miss, else: {:ok, res} end).()
  end

  defp match_rules(message, ruleset, rules) do
    rules
    |> Enum.map(&match_rule(message, ruleset, &1))
    |> Enum.find(:miss, fn res -> match?({:ok, _}, res) end)
  end

  defp match_all(message, ruleset, rules) do
    case match_rules(message, ruleset, rules) do
      {:ok, reminder} -> {:cont, reminder}
      :miss -> {:halt, :miss}
    end
  end
end
