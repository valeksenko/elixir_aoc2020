defmodule AoC2020.Day05.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day05.Part1
  import AoC2020.Day05.Part1
  import TestHelper

  test "checks for sample input" do
    assert 820 == run(read_example(:day05))
  end
end
