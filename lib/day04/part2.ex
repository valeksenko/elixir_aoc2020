defmodule AoC2020.Day04.Part2 do
  @behaviour AoC2020.Day

  @required_fields ~w[ byr iyr eyr hgt hcl ecl pid ]

  @impl AoC2020.Day
  def run(data) do
    data |> Enum.chunk_by(&(&1 == "")) |> Enum.filter(&(&1 != [ "" ])) |> Enum.count(&valid_passport?/1)
  end

  defp valid_passport?(entries) do
    entries |> Enum.flat_map(&extract_fields/1) |> Map.new(fn [k, v] -> {k, v} end) |> valid_fields?
  end

  defp extract_fields(entry) do
    entry |> String.split(" ") |> Enum.map(fn f -> f |> String.split(":") end)
  end

  defp valid_fields?(passport) do
    @required_fields |> Enum.all?(&(valid_field?(&1, passport[&1])))
  end

  defp valid_field?(_, nil) do
    false
  end

  defp valid_field?("byr", value) do
    String.to_integer(value) in 1920 .. 2002
  end

  defp valid_field?("iyr", value) do
    String.to_integer(value) in 2010 .. 2020
  end

  defp valid_field?("eyr", value) do
    String.to_integer(value) in 2020 .. 2030
  end

  defp valid_field?("hgt", value) do
    cond do
      String.match?(value, ~r/\A\d+cm\Z/) -> to_integer(value) in 150 .. 193
      String.match?(value, ~r/\A\d+in\Z/) -> to_integer(value) in 59 .. 76
      true -> false
    end
  end

  defp valid_field?("hcl", value) do
    String.match?(value, ~r/\A#[\da-f]{6}\Z/)
  end

  defp valid_field?("ecl", value) do
    value in ~w[ amb blu brn gry grn hzl oth ]
  end

  defp valid_field?("pid", value) do
    String.match?(value, ~r/\A\d{9}\Z/)
  end

  def to_integer(value) do
    Regex.named_captures(~r/(?<num>\d+)/, value)["num"] |> String.to_integer
  end
end
