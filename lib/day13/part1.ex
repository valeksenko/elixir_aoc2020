defmodule AoC2020.Day13.Part1 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run([departure, timeline | []]) do
    departure = String.to_integer(departure)

    timeline
    |> String.split(",")
    |> Enum.filter(&(&1 != "x"))
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn id -> {id, time(id, departure)} end)
    |> Enum.min_by(&elem(&1, 1))
    |> result(departure)
  end

  defp time(id, departure) do
    div(departure, id) * id + if rem(departure, id) == 0, do: 0, else: id
  end

  defp result({id, bus_time}, departure) do
    id * (bus_time - departure)
  end
end
