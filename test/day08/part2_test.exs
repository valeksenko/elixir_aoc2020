defmodule AoC2020.Day08.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day08.Part2
  import AoC2020.Day08.Part2
  import TestHelper

  test "checks for sample input" do
    assert 8 == run(read_example(:day08))
  end
end
