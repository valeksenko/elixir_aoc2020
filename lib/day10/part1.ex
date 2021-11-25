defmodule AoC2020.Day10.Part1 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> calculate
  end

  def calculate(data) do
    count(data, 1) * (count(data, 3) + 1)
  end

  def count(data, step) do
    data
    |> Enum.reduce({0, 0}, fn curr, {prev, amount} -> if (curr - prev) == step, do: {curr, amount + 1}, else: {curr, amount} end)
    |> elem(1)
  end
end
