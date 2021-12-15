defmodule AoC2020.Day24.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day24.Part2
  import AoC2020.Day24.Part2
  import TestHelper

  test "checks for sample input" do
    assert 37 == run(read_example(:day24))
  end
end
