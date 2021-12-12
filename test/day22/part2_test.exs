defmodule AoC2020.Day22.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day22.Part2
  import AoC2020.Day22.Part2
  import TestHelper

  test "checks for sample input" do
    assert 291 == run(read_example_file(:day22))
  end
end
