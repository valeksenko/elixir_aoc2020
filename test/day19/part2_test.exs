defmodule AoC2020.Day19.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day19.Part2
  import AoC2020.Day19.Part2
  import TestHelper

  test "checks for sample input" do
    assert 12 == run(read_example_file(:day19_1))
  end
end
