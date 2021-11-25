defmodule AoC2020.Day08.Parser do
  import NimbleParsec
  alias AoC2020.Day08.BootCode.Instruction

  whitespace = ascii_string([?\s], min: 1)

  op =
    ascii_string([?a..?z], 3)
    |> tag(:op)

  argument =
    ignore(optional(ascii_char([?+])))
    |> optional(ascii_char([?-]))
    |> integer(min: 1)
    |> post_traverse({:sign_int, []})
    |> tag(:argument)

  defp sign_int(_, [int, _neg], context, _, _) do
    {[int * -1], context}
  end

  defp sign_int(_, res, context, _, _) do
    {res, context}
  end

  # Example: "acc -99"
  instruction =
    op
    |> ignore(whitespace)
    |> concat(argument)
    |> eos()

  defparsec(:parse, instruction)

  def code_parser(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&to_instruction/1)
  end

  defp to_instruction({:ok, [op: [op], argument: [argument]], _, _, _, _}) do
    %Instruction{op: op, argument: argument}
  end
end
