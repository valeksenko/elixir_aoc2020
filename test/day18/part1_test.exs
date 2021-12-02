defmodule AoC2020.Day18.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day18.Part1
  import AoC2020.Day18.Part1
  import TestHelper

  test "checks for sample input" do
    assert 26335 == run(read_example(:day18))
  end
end
