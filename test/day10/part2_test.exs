defmodule AoC2020.Day10.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day10.Part2
  import AoC2020.Day10.Part2
  import TestHelper

  test "checks for sample input" do
    assert 8 == run(read_example(:day10))
    assert 19208 == run(read_example(:day10_1))
  end
end
