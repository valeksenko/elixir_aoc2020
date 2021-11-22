defmodule AoC2020.Day03.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day03.Part1
  import AoC2020.Day03.Part1
  import TestHelper

  test "checks for sample input" do
    assert 7 == run(read_example(:day03))
  end
end
