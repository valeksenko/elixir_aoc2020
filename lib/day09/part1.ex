defmodule AoC2020.Day09.Part1 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&String.to_integer/1)
    |> find(25)
  end

  def find(data, window) do
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
