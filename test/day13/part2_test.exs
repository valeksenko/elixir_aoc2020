defmodule AoC2020.Day13.Part2Test do
  use ExUnit.Case
  doctest AoC2020.Day13.Part2
  import AoC2020.Day13.Part2

  test "checks for sample input" do
    assert 3417 == find("17,x,13,19")
    assert 1_068_781 == find("7,13,x,x,59,x,31,19")
    assert 754_018 == find("67,7,59,61")
    assert 779_210 == find("67,x,7,59,61")
    assert 1_261_476 == find("67,7,x,59,61")
    # too slow for brute force
    # assert 1202161486 == find("1789,37,47,1889")
  end
end
