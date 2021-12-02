defmodule AoC2020.Day18.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day18.Part2
  import AoC2020.Day18.Part2
  import TestHelper

  test "checks for sample input" do
    assert 693_891 == run(read_example(:day18))
  end
end
