defmodule AoC2020.Day25.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day25.Part1
  import AoC2020.Day25.Part1
  import TestHelper

  test "checks for sample input" do
    assert 14_897_079 == run(read_example(:day25))
  end
end
