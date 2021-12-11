defmodule AoC2020.Day22.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day22.Part1
  import AoC2020.Day22.Part1
  import TestHelper

  test "checks for sample input" do
    assert 306 == run(read_example_file(:day22))
  end
end
