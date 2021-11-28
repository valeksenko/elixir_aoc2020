defmodule AoC2020.Day13.Part2 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run([_, timeline | []]) do
    find(timeline)
  end

  def find(timeline) do
    timeline
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.filter(&(elem(&1, 0) != "x"))
    |> Enum.map(fn {id, ind} -> {String.to_integer(id), ind} end)
    |> remainder
  end

  # Stolen from https://rosettacode.org/wiki/Chinese_remainder_theorem#Elixir
  def remainder(buses) do
    mods = Enum.map(buses, &elem(&1, 0))
    remainders = Enum.map(buses, fn {id, ind} -> id - ind end)
    max = Enum.reduce(mods, fn x, acc -> x * acc end)

    Enum.zip(mods, remainders)
    |> Enum.map(fn {m, r} -> Enum.take_every(r..max, m) |> MapSet.new() end)
    |> Enum.reduce(fn set, acc -> MapSet.intersection(set, acc) end)
    |> MapSet.to_list()
    |> hd
  end
end
