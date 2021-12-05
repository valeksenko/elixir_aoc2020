defmodule AoC2020.Day18.Part2 do
  @behaviour AoC2020.Day

  @add &+/2
  @prod &*/2

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&calculate/1)
    |> Enum.sum()
  end

  defp calculate(datum) do
    datum
    |> String.graphemes()
    |> calc([])
    |> elem(1)
  end

  defp calc_op(op, code) do
    [init | stack] = Enum.reverse(code)

    stack
    |> Enum.chunk_every(2)
    |> Enum.reduce([init], fn [o, n1], [n2 | reminder] ->
      if o == op, do: [o.(n1, n2) | reminder], else: [n1, o, n2] ++ reminder
    end)
  end

  defp calc([], prev) do
    total =
      [@add, @prod]
      |> Enum.reduce(prev, &calc_op/2)
      |> hd

    {[], total}
  end

  defp calc([op | reminder], prev) do
    case op do
      " " -> calc(reminder, prev)
      "+" -> calc(reminder, [@add | prev])
      "*" -> calc(reminder, [@prod | prev])
      "(" -> calc(reminder, []) |> (fn {r, t} -> calc(r, [t | prev]) end).()
      ")" -> {reminder, calc([], prev) |> elem(1)}
      _ -> calc(reminder, [String.to_integer(op) | prev])
    end
  end
end
