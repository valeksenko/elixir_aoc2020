defmodule AoC2020.Day14.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day14.Part2
  import AoC2020.Day14.Part2
  import TestHelper

  test "checks for sample input" do
    assert 208 == run(read_example(:day14_1))
  end
end
