defmodule AoC2020.Day10.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day10.Part1
  import AoC2020.Day10.Part1
  import TestHelper

  test "checks for sample input" do
    assert 35 == run(read_example(:day10))
    assert 220 == run(read_example(:day10_1))
  end
end
