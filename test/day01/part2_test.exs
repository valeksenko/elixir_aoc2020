defmodule AoC2020.Day01.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day01.Part2
  import AoC2020.Day01.Part2

  test "finds for sample input" do
    assert 241_861_950 == find([1721, 979, 366, 299, 675, 1456])
  end
end
