defmodule AoC2020.Day20.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day20.Part1
  import AoC2020.Day20.Part1
  import TestHelper

  test "checks for sample input" do
    assert 20899048083289 == run(read_example_file(:day20))
  end
end
