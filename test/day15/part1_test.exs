defmodule AoC2020.Day15.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day15.Part1
  import AoC2020.Day15.Part1

  test "checks for sample input" do
    assert 436 == find([0, 3, 6])
    assert 1 == find([1, 3, 2])
    assert 10 == find([2, 1, 3])
    assert 27 == find([1, 2, 3])
    assert 78 == find([2, 3, 1])
    assert 438 == find([3, 2, 1])
    assert 1836 == find([3, 1, 2])
  end
end
