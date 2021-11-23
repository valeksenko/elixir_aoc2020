defmodule AoC2020.Day06.Part1 do
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
    |> Enum.reduce(MapSet.new(), &add_answer/2)
    |> MapSet.size()
  end

  defp add_answer(entry, answers) do
    entry
    |> String.graphemes()
    |> Enum.reduce(answers, &MapSet.put(&2, &1))
  end
end
