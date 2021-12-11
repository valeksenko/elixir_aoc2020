defmodule AoC2020.Day21.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day21.Part1
  import AoC2020.Day21.Part1
  import TestHelper

  test "checks for sample input" do
    assert 5 == run(read_example(:day21))
  end
end
