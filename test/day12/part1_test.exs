defmodule AoC2020.Day12.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day12.Part1
  import AoC2020.Day12.Part1
  import TestHelper

  test "checks for sample input" do
    assert 25 == run(read_example(:day12))
  end
end
