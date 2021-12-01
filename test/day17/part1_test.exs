defmodule AoC2020.Day17.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day17.Part1
  import AoC2020.Day17.Part1
  import TestHelper

  test "checks for sample input" do
    assert 112 == run(read_example(:day17))
  end
end
