defmodule AoC2020.Day16.Parser do
  import NimbleParsec

  whitespace = ascii_string([?\s], min: 1)
  new_line = ascii_string([?\n], 1)
  value = integer(min: 1)
  field = ascii_string([?a..?z, ?\s], min: 1)

  range =
    integer(min: 1)
    |> ignore(string("-"))
    |> integer(min: 1)
    |> reduce({:to_range, []})

  ranges =
    range
    |> times(
      ignore(whitespace |> string("or") |> concat(whitespace))
      |> concat(range),
      min: 0
    )
    |> tag(:range)

  rule =
    field
    |> tag(:field)
    |> ignore(string(":") |> concat(whitespace))
    |> concat(ranges)
    |> tag(:rule)
    |> ignore(new_line)

  rules =
    repeat(
      lookahead_not(new_line |> concat(new_line))
      |> concat(rule)
    )
    |> tag(:rules)
    |> ignore(new_line)

  ticket =
    value
    |> times(
      ignore(string(","))
      |> concat(value),
      min: 0
    )
    |> ignore(optional(new_line))

  my_ticket =
    ignore(string("your ticket:") |> concat(new_line))
    |> concat(ticket)
    |> tag(:my_ticket)
    |> ignore(new_line)

  other_tickets =
    ignore(string("nearby tickets:") |> concat(new_line))
    |> repeat(
      lookahead_not(new_line |> concat(new_line))
      |> concat(ticket)
      |> tag(:ticket)
    )
    |> tag(:other_tickets)

  defp to_range([min, max]), do: min..max

  defparsec(:parse, rules |> concat(my_ticket) |> concat(other_tickets))

  def notes_parser(data) do
    case parse(data) do
      {:ok, [rules: rules, my_ticket: my_ticket, other_tickets: other_tickets], _, _, _, _} ->
        {rules |> Enum.reduce(Map.new(), &to_rule/2), my_ticket,
         other_tickets |> Enum.map(fn {:ticket, l} -> l end)}
    end
  end

  defp to_rule({:rule, [field: [field], range: ranges]}, rules) do
    Map.put(rules, field, ranges)
  end
end
