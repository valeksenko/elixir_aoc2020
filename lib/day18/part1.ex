defmodule AoC2020.Day18.Part1 do
  @behaviour AoC2020.Day

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

  defp calc([], prev) do
    [init | stack] = Enum.reverse(prev)

    total =
      stack
      |> Enum.chunk_every(2)
      |> Enum.reduce(init, fn [op, n1], n2 -> op.(n1, n2) end)

    {[], total}
  end

  defp calc([op | reminder], prev) do
    case op do
      " " -> calc(reminder, prev)
      "+" -> calc(reminder, [(&+/2) | prev])
      "*" -> calc(reminder, [(&*/2) | prev])
      "(" -> calc(reminder, []) |> (fn {r, t} -> calc(r, [t | prev]) end).()
      ")" -> {reminder, calc([], prev) |> elem(1)}
      _ -> calc(reminder, [String.to_integer(op) | prev])
    end
  end
end
