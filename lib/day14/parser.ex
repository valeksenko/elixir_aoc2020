defmodule AoC2020.Day14.Parser do
  import NimbleParsec
  alias AoC2020.Day14.Instruction

  mask =
    ignore(string("mask = "))
    |> ascii_string([?X, ?0..?9], 36)
    |> tag(:mask)

  setter =
    ignore(string("mem["))
    |> integer(min: 1)
    |> tag(:memory)
    |> ignore(string("] = "))
    |> integer(min: 1)
    |> tag(:value)

  # Example:
  # mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
  # mem[8] = 11
  instruction =
    choice([
      mask,
      setter
    ])
    |> eos()

  defparsec(:parse, instruction)

  def code_parser(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&to_instruction/1)
  end

  defp to_instruction({:ok, [mask: [mask]], _, _, _, _}) do
    %Instruction{op: "mask", argument: mask}
  end

  defp to_instruction({:ok, [value: [{:memory, [memory]}, value]], _, _, _, _}) do
    %Instruction{op: "set", argument: {memory, value}}
  end
end
