defmodule AoC2020.Day25.Part1 do
  @behaviour AoC2020.Day

  @subject 7
  @max 20_201_227

  @impl AoC2020.Day
  def run(data) do
    [door_pk, card_pk] = data |> Enum.map(&String.to_integer/1)

    transform(1, door_pk, loop_size(card_pk, 1, 0))
  end

  defp next(number, subject), do: rem(number * subject, @max)

  defp loop_size(match, match, loop), do: loop
  defp loop_size(pk, number, loop), do: loop_size(pk, next(number, @subject), loop + 1)

  defp transform(number, _, 0), do: number
  defp transform(number, subject, loop), do: transform(next(number, subject), subject, loop - 1)
end
