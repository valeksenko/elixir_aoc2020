defmodule AoC2020.Day11.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day11.Part1
  import AoC2020.Day11.Part1
  import TestHelper

  test "checks for sample input" do
    assert 37 == run(read_example(:day11))
  end
end
