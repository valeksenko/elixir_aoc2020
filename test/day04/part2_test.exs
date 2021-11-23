defmodule AoC2020.Day04.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day04.Part2
  import AoC2020.Day04.Part2
  import TestHelper

  test "checks for sample input" do
    assert 4 == run(read_example(:day04_valid, false))
    assert 0 == run(read_example(:day04_invalid, false))
  end
end
