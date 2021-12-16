defmodule AoC2020.Day23.Part2 do
  @behaviour AoC2020.Day

  @steps 10_000_000
  @last 1_000_000

  @impl AoC2020.Day
  def run(data) do
    data
    |> hd
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> fill
    |> play(@steps)
    |> result
  end

  defp play({_, numbers}, 0), do: numbers

  defp play({current, numbers}, step) do
    if rem(step, 1_000_000) == 0, do: IO.inspect(step)

    n1 = numbers[current]
    n2 = numbers[n1]
    n3 = numbers[n2]

    n = next(current - 1, [n1, n2, n3])

    updated =
      numbers
      |> Map.put(current, numbers[n3])
      |> Map.put(n3, numbers[n])
      |> Map.put(n2, n3)
      |> Map.put(n1, n2)
      |> Map.put(n, n1)

    play({updated[current], updated}, step - 1)
  end

  defp next(0, exclude), do: next(@last, exclude)

  defp next(number, exclude) do
    if number in exclude, do: next(number - 1, exclude), else: number
  end

  defp fill(numbers) do
    current = hd(numbers)
    all = numbers ++ Enum.to_list(length(numbers)..@last)

    {current, [{@last, current} | Enum.zip(all, tl(all))] |> Map.new()}
  end

  defp result(numbers) do
    n = numbers[1]

    n * numbers[n]
  end
end
