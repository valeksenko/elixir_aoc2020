defmodule AoC2020.Day02.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day02.Part1
  import AoC2020.Day02.Part1

  test "checks for sample input" do
    assert 2 ==
             run([
               "1-3 a: abcde",
               "1-3 b: cdefg",
               "2-9 c: ccccccccc"
             ])
  end
end
