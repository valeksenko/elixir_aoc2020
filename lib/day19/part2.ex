defmodule AoC2020.Day19.Part2 do
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
    message = input |> String.graphemes()

    match_rules([message], ruleset, Map.fetch!(ruleset, @initial))
    |> Enum.any?(&Enum.empty?/1)
  end

  defp match_rules(messages, ruleset, rules) do
    rules
    |> Enum.flat_map(&match_rule(messages, ruleset, &1))
    |> Enum.dedup()
  end

  defp match_rule([], _, _), do: []
  defp match_rule([""], _, _), do: []

  defp match_rule(messages, ruleset, {:rule, definitions}),
    do: match_all(messages, ruleset, definitions)

  defp match_rule(messages, _, {:match, [match]}) do
    messages
    |> Enum.filter(&match?([^match | _], &1))
    |> Enum.map(&tl/1)
  end

  defp match_all(messages, ruleset, rules) do
    messages
    |> Enum.flat_map(fn m ->
      rules
      |> Enum.map(&Map.fetch!(ruleset, &1))
      |> Enum.reduce([m], &match_rules(&2, ruleset, &1))
    end)
  end
end
