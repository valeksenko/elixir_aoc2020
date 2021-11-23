defmodule AoC2020.Day06.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day06.Part2
  import AoC2020.Day06.Part2
  import TestHelper

  test "checks for sample input" do
    assert 6 == run(read_example(:day06, false))
  end
end
