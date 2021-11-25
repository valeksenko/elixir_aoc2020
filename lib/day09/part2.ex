defmodule AoC2020.Day09.Part2 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&String.to_integer/1)
    |> find(25)
  end

  def find(data, window) do
    target = find_invalid(data, window)

    data
    |> Stream.iterate(&tl/1)
    |> Enum.find_value(&match(&1, [], target))
    |> Enum.min_max()
    |> Tuple.sum()
  end

  def match([], _), do: false

  def match([x | xs], collected, target) do
    res = [x | collected]
    sum = Enum.sum(res)

    cond do
      sum == target -> res
      sum < target -> match(xs, res, target)
      true -> false
    end
  end

  def find_invalid(data, window) do
    data
    |> Stream.iterate(&tl/1)
    |> Enum.find_value(fn l -> invalid(Enum.take(l, window), Enum.fetch!(l, window)) end)
  end

  defp invalid([_], target), do: target

  defp invalid([x | xs], target) do
    if Enum.find(xs, &(x + &1 == target)) do
      false
    else
      invalid(xs, target)
    end
  end
end
