defmodule AoC2020.Day19.Parser do
  import NimbleParsec

  whitespace = ascii_string([?\s], min: 1)
  quotesign = ascii_string([?"], 1)
  new_line = ascii_string([?\n], 1)
  id = integer(min: 1)
  match = ascii_string([?a..?z], min: 1)

  match_definition =
    ignore(quotesign)
    |> ascii_string([?a..?z], 1)
    |> ignore(quotesign)

  rule_definition =
    id
    |> times(
      ignore(whitespace)
      |> concat(id),
      min: 0
    )
    |> tag(:rule)

  definitions =
    choice([
      match_definition
      |> tag(:match),
      rule_definition
      |> times(
        ignore(whitespace |> string("|") |> concat(whitespace))
        |> concat(rule_definition),
        min: 0
      )
    ])

  rule =
    id
    |> ignore(string(":") |> concat(whitespace))
    |> wrap(definitions)
    |> tag(:rule_definition)
    |> ignore(new_line)

  rules =
    repeat(
      lookahead_not(new_line |> concat(new_line))
      |> concat(rule)
    )
    |> tag(:rules)
    |> ignore(new_line)

  matches =
    repeat(
      match
      |> ignore(optional(new_line))
    )
    |> tag(:matches)

  defparsec(:parse, rules |> concat(matches))

  def rule_parser(data) do
    case parse(data) do
      {:ok, [rules: rules, matches: matches], _, _, _, _} ->
        {rules |> Enum.reduce(Map.new(), &to_rule/2), matches}
    end
  end

  defp to_rule({:rule_definition, [id, rule]}, rules) do
    Map.put(rules, id, rule)
  end
end
