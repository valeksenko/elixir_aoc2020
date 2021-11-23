defmodule AoC2020.Day06.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day06.Part1
  import AoC2020.Day06.Part1
  import TestHelper

  test "checks for sample input" do
    assert 11 == run(read_example(:day06, false))
  end
end
