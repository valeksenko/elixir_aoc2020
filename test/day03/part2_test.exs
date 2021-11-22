defmodule AoC2020.Day03.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day03.Part2
  import AoC2020.Day03.Part2
  import TestHelper

  test "checks for sample input" do
    assert 336 == run(read_example(:day03))
  end
end
