defmodule AoC2020.Day22.Part1 do
  import AoC2020.Day22.Parser

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    deck_parser(data)
    |> play
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.map(&Tuple.product/1)
    |> Enum.sum()
  end

  defp play({[], winner}), do: winner
  defp play({winner, []}), do: winner

  defp play({[x | xs], [y | ys]}) do
    if x > y, do: play({xs ++ [x, y], ys}), else: play({xs, ys ++ [y, x]})
  end
end
