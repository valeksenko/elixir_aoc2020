defmodule AoC2020.Day24.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day24.Part1
  import AoC2020.Day24.Part1
  import TestHelper

  test "checks for sample input" do
    assert 10 == run(read_example(:day24))
  end
end
