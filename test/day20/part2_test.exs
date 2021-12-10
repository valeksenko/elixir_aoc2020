defmodule AoC2020.Day20.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day20.Part2
  import AoC2020.Day20.Part2
  import TestHelper

  test "checks for sample input" do
    assert 273 == run(read_example_file(:day20))
  end
end
