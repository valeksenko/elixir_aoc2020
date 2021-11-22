defmodule AoC2020.Day04.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day04.Part1
  import AoC2020.Day04.Part1
  import TestHelper

  test "checks for sample input" do
    assert 2 == run(read_example(:day04, false))
  end
end
