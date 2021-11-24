defmodule AoC2020.Day07.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day07.Part1
  import AoC2020.Day07.Part1
  import TestHelper

  test "checks for sample input" do
    assert 4 == run(read_example(:day07))
  end
end
