defmodule AoC2020.Day13.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day13.Part1
  import AoC2020.Day13.Part1
  import TestHelper

  test "checks for sample input" do
    assert 295 == run(read_example(:day13))
  end
end
