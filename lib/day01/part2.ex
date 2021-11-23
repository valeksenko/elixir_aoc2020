defmodule AoC2020.Day01.Part2 do
  @behaviour AoC2020.Day

  @total 2020

  @impl AoC2020.Day
  def run(data) do
    data |> Enum.map(&String.to_integer/1) |> find
  end

  def find(report) do
    find_match(report) |> Tuple.product()
  end

  defp find_match(report) do
    report |> gen_lists |> Enum.find_value(&matching/1)
  end

  defp matching([]), do: nil
  defp matching([_]), do: nil

  defp matching([x | xs]) do
    case xs |> gen_lists |> Enum.find_value(&matching_pair(@total - x, &1)) do
      nil -> nil
      {y, z} -> {x, y, z}
    end
  end

  defp matching_pair(_, []), do: nil
  defp matching_pair(_, [_]), do: nil

  defp matching_pair(total, [x | xs]) do
    case Enum.find(xs, &(&1 + x == total)) do
      nil -> nil
      match -> {x, match}
    end
  end

  defp gen_lists(l), do: Stream.scan(l, [], &[&1 | &2])
end
