defmodule AoC2020.Day15.Part1 do
  @behaviour AoC2020.Day

  @amount 2020

  @impl AoC2020.Day
  def run(data) do
    data
    |> hd
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> find()
  end

  def find(numbers) do
    {last, initial} = List.pop_at(numbers, length(numbers) - 1)

    state =
      initial
      |> Enum.with_index(1)
      |> Enum.reduce(Map.new(), fn {n, i}, map -> Map.put(map, n, i) end)

    length(numbers)..(@amount - 1)
    |> Enum.reduce({last, state}, &next_number/2)
    |> elem(0)
  end

  def next_number(index, {last, state}) do
    last_index = Map.get(state, last)
    next = if last_index, do: index - last_index, else: 0

    {next, Map.put(state, last, index)}
  end
end
