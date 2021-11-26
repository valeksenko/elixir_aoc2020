defmodule AoC2020.Day10.Part2 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> calculate()
  end

  def calculate(data) do
    {[1], [0 | data]}
    |> Stream.iterate(fn {r, l} -> {[count(l) | r], tl(l)} end)
    |> Enum.find(fn {_, l} -> length(l) < 3 end)
    |> elem(0)
    |> Enum.reverse()
    |> result()
  end

  defp result(counts) do
    counts
    |> tl()
    |> Enum.zip(counts)
    |> Enum.reduce(1, &prod/2)
  end

  defp prod(res, total) do
    case res do
      {3, 1} -> total * 4
      {3, 3} -> div(total, 4) * 7
      {2, 1} -> total * 2
      _ -> total
    end
  end

  defp count(adapters) do
    case adapters |> Enum.take(4) |> diff do
      [1, 1, 1] -> 3
      [1, 1, _] -> 2
      _ -> 1
    end
  end

  defp diff(adapters) do
    adapters
    |> Enum.zip(tl(adapters))
    |> Enum.map(fn {x, y} -> y - x end)
  end
end
