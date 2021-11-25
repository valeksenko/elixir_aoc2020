defmodule AoC2020.Day07.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day07.Part2
  import AoC2020.Day07.Part2
  import TestHelper

  test "checks for sample input" do
    assert 32 == run(read_example(:day07))
    assert 126 == run(read_example(:day07_1))
  end
end
