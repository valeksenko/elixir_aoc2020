defmodule AoC2020.Day11.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day11.Part2
  import AoC2020.Day11.Part2
  import TestHelper

  test "checks for sample input" do
    assert 26 == run(read_example(:day11))
  end
end
