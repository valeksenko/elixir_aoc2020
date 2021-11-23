defmodule AoC2020.Day05.Part1 do
  import AoC2020.Day05.Base, only: [seat: 1, seat_id: 1]

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&seat/1)
    |> Enum.map(&seat_id/1)
    |> Enum.max()
  end
end
