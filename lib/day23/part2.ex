defmodule AoC2020.Day23.Part2 do
  @behaviour AoC2020.Day

  @steps 10_000_000
  @total 1_000_000

  @impl AoC2020.Day
  def run(data) do
    data
    |> hd
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> fill(@total)
    |> play(@steps)
    |> result
  end

  defp play(l, 0), do: l

  defp play([x, x1, x2, x3 | xs], step) do
    xs
    |> Enum.filter(&(x > &1))
    |> insert(xs, [x1, x2, x3])
    |> Enum.concat([x])
    |> play(step - 1)
  end

  defp fill(numbers, total) do
    numbers ++ Enum.to_list(length(numbers)..(total - 1))
  end

  defp insert(l1, l2, pick) do
    destination = if(Enum.empty?(l1), do: l2, else: l1) |> Enum.max()

    l2
    |> Enum.split_while(&(&1 != destination))
    |> update(pick)
  end

  defp update({x, [y | ys]}, pick) do
    x ++ [y | pick] ++ ys
  end

  defp result(numbers) do
    [_, n1, n2] = Enum.drop_while(numbers, &(&1 != 1)) |> Enum.take(3)

    n1 * n2
  end
end
