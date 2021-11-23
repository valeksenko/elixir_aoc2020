defmodule AoC2020.Day04.Part1 do
  @behaviour AoC2020.Day

  @required_fields ~w[ byr iyr eyr hgt hcl ecl pid ]

  @impl AoC2020.Day
  def run(data) do
    data
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.count(&valid_passport?/1)
  end

  defp valid_passport?(entries) do
    keys = entries |> Enum.flat_map(&extract_keys/1)
    (@required_fields -- keys) |> Enum.empty?()
  end

  defp extract_keys(entry) do
    entry |> String.split(" ") |> Enum.map(fn f -> f |> String.split(":") |> hd end)
  end
end
