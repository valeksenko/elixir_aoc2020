defmodule AoC2020.Day14.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day14.Part1
  import AoC2020.Day14.Part1
  import TestHelper

  test "checks for sample input" do
    assert 165 == run(read_example(:day14))
  end
end
