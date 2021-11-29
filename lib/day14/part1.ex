defmodule AoC2020.Day14.Part1 do
  use Bitwise
  import AoC2020.Day14.Parser
  alias AoC2020.Day14.Instruction

  @behaviour AoC2020.Day

  @bitsize 36

  @impl AoC2020.Day
  def run(data) do
    data
    |> code_parser
    |> Enum.reduce({Map.new(), {0, 0}}, &exec/2)
    |> elem(0)
    |> Map.values()
    |> Enum.sum()
  end

  defp exec(%Instruction{op: "mask", argument: mask}, {ram, _}) do
    {ram, to_bit_masks(mask)}
  end

  defp exec(%Instruction{op: "set", argument: {address, value}}, {ram, masks}) do
    {Map.put(ram, address, apply_mask(value, masks)), masks}
  end

  defp apply_mask(value, {and_mask, xor_mask}) do
    bxor(value &&& and_mask, xor_mask)
  end

  defp to_bit_masks(mask) do
    {
      mask
      |> String.replace("1", "0")
      |> String.replace("X", "1")
      |> String.to_integer(2),
      mask
      |> String.replace("X", "0")
      |> String.to_integer(2)
    }
  end
end
