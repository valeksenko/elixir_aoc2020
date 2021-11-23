defmodule AoC2020.Day05.Part1 do
  @behaviour AoC2020.Day

  @id_multiplier 8

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.map(&to_seat_id/1)
    |> Enum.max()
  end

  defp to_seat_id(pass) do
    {row_code, col_code} = pass |> String.split_at(7)
    seat_id(
      decode(row_code, 128, "F", "B"),
      decode(col_code, 8, "L", "R")
    )
  end

  defp decode(code, amount, lower, upper) do
    code
    |> String.graphemes()
    |> Enum.reduce({0, amount / 2}, fn code, res -> calc(code, res, lower, upper) end)
    |> elem(0)
  end

  defp calc(code, {num, amount}, lower, upper) do
    case code do
      ^lower -> {num, amount / 2}
      ^upper -> {num + amount, amount / 2}
    end
  end

  defp seat_id(row, col) do
    row * @id_multiplier + col
  end
end
