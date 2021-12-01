defmodule AoC2020.Day16.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day16.Part2
  import AoC2020.Day16.Part2
  import TestHelper

  test "checks for sample input" do
    assert 132 == run(read_example_file(:day16_1))
  end
end
