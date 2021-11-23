defmodule AoC2020.Day06.Part2 do
  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(&answers_count/1)
    |> Enum.sum()
  end

  defp answers_count(entries) do
    entries
    |> Enum.map(&(String.graphemes(&1) |> MapSet.new()))
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.size()
  end
end
