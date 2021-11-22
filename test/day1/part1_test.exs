defmodule AoC2020.Day01.Part1Test do
  use ExUnit.Case
  doctest AoC2020.Day01.Part1
  import AoC2020.Day01.Part1

  test "finds for sample input" do
    assert 514579 == find [ 1721, 979, 366, 299, 675, 1456 ]
  end
end
