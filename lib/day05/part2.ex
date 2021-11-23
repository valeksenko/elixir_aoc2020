defmodule AoC2020.Day05.Part2 do
  import AoC2020.Day05.Base, only: [seat: 1, seat_id: 1]

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&seat/1)
    |> my_seat
  end

  defp my_seat(seats) do
    seats
    |> Enum.group_by(&elem(&1, 0))
    |> Enum.find(fn {_, col_seats} -> length(col_seats) == 7 end)
    |> elem(1)
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.zip(0..7)
    |> Enum.find(fn {{_, col}, ind} -> ind != trunc(col) end)
    |> elem(0)
    |> (fn {row, col} -> {row, col - 1} end).()
    |> seat_id
  end
end
