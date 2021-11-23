defmodule AoC2020.Day05.Base do
  @id_multiplier 8

  def seat(pass) do
    {row_code, col_code} = pass |> String.split_at(7)

    {
      decode(row_code, 128, "F", "B"),
      decode(col_code, 8, "L", "R")
    }
  end

  def seat_id({row, col}) do
    row * @id_multiplier + col
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
end
