defmodule AoC2020.Day16.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day16.Part1
  import AoC2020.Day16.Part1
  import TestHelper

  test "checks for sample input" do
    assert 71 == run(read_example_file(:day16))
  end
end
