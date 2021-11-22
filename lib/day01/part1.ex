defmodule AoC2020.Day01.Part1 do
  @behaviour AoC2020.Day

  @total 2020

  @impl AoC2020.Day
  def run(data) do
    data |> Enum.map(&String.to_integer/1) |> find
  end

  def find(report) do
    find_match(report) |> Tuple.product
  end

  defp find_match(report) do
    report |> Stream.scan([], &([ &1 | &2 ])) |> Enum.find_value(&matching_pair/1)
  end

  defp matching_pair([]), do: nil
  defp matching_pair([ _ ]), do: nil
  defp matching_pair([ x | xs ]) do
    case Enum.find(xs, &((&1 + x) == @total)) do
      nil -> nil
      match -> { x, match }
    end
  end
end
