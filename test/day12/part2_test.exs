defmodule AoC2020.Day12.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day12.Part2
  import AoC2020.Day12.Part2
  import TestHelper

  test "checks for sample input" do
    assert 286 == run(read_example(:day12))
  end
end
