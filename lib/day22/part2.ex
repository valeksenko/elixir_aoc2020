defmodule AoC2020.Day22.Part2 do
  import AoC2020.Day22.Parser

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    deck_parser(data)
    |> play({[], []})
    |> elem(1)
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.map(&Tuple.product/1)
    |> Enum.sum()
  end

  defp play({winner, []}, _), do: {0, winner}
  defp play({[], winner}, _), do: {1, winner}

  defp play({deck1, deck2}, {prev1, prev2}) do
    cond do
      deck1 in prev1 -> {0, deck1}
      deck2 in prev2 -> {0, deck1}
      true -> play_round(deck1, deck2) |> play({[deck1 | prev1], [deck2 | prev2]})
    end
  end

  defp play_round([x | xs], [y | ys]) when length(xs) >= x and length(ys) >= y do
    case play({Enum.take(xs, x), Enum.take(ys, y)}, {[], []}) do
      {0, _} -> {xs ++ [x, y], ys}
      {1, _} -> {xs, ys ++ [y, x]}
    end
  end

  defp play_round([x | xs], [y | ys]) do
    if x > y, do: {xs ++ [x, y], ys}, else: {xs, ys ++ [y, x]}
  end
end
