defmodule AoC2020.Day23.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day23.Part1
  import AoC2020.Day23.Part1
  import TestHelper

  test "checks for sample input" do
    assert 67_384_529 == run(read_example(:day23))
  end
end
