defmodule AoC2020.Day14.Part2 do
  use Bitwise
  import AoC2020.Day14.Parser
  alias AoC2020.Day14.Instruction

  @behaviour AoC2020.Day

  @bitsize 36
  @max trunc(:math.pow(2, @bitsize)) - 1

  @impl AoC2020.Day
  def run(data) do
    data
    |> code_parser
    |> Enum.reduce({Map.new(), {0, []}}, &exec/2)
    |> elem(0)
    |> Map.values()
    |> Enum.sum()
  end

  defp exec(%Instruction{op: "mask", argument: mask}, {ram, _}) do
    {ram, to_masks(mask)}
  end

  defp exec(%Instruction{op: "set", argument: {address, value}}, {ram, masks}) do
    {
      apply_mask(address, masks) |> Enum.reduce(ram, fn a, r -> Map.put(r, a, value) end),
      masks
    }
  end

  defp apply_mask(address, {or_mask, x_bits}) do
    x_bits |> Enum.reduce([address ||| or_mask], &flip_bit/2)
  end

  defp flip_bit(bit, result) do
    shift = 1 <<< bit

    result
    |> Enum.flat_map(fn num -> [num &&& bxor(@max, shift), num ||| shift] end)
  end

  defp to_masks(mask) do
    {
      mask
      |> String.replace("X", "0")
      |> String.to_integer(2),
      mask
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) == "X"))
      |> Enum.map(&elem(&1, 1))
      |> Enum.reverse()
    }
  end
end
