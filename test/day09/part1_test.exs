defmodule AoC2020.Day09.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day09.Part1
  import AoC2020.Day09.Part1
  import TestHelper

  test "checks for sample input" do
    assert 127 == read_example(:day09) |> Enum.map(&String.to_integer/1) |> find(5)
  end
end
