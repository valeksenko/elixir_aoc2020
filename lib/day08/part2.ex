defmodule AoC2020.Day08.Part2 do
  import AoC2020.Day08.Parser
  import AoC2020.Day08.BootCode
  alias AoC2020.Day08.BootCode

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> code_parser
    |> find
  end

  defp find(code) do
    {0, code}
    |> Stream.iterate(fn {line, _} -> modify({line, code}) end)
    |> Stream.map(&(elem(&1, 1) |> exec))
    |> Enum.find(&(&1 != :loop))
  end

  defp modify({line, code}) do
    next_code =
      case Enum.fetch!(code, line) do
        %BootCode.Instruction{op: "jmp", argument: argument} ->
          code |> List.replace_at(line, %BootCode.Instruction{op: "nop", argument: argument})

        %BootCode.Instruction{op: "nop", argument: argument} ->
          code |> List.replace_at(line, %BootCode.Instruction{op: "jmp", argument: argument})

        _ ->
          code
      end

    if code == next_code do
      modify({line + 1, code})
    else
      {line + 1, next_code}
    end
  end

  defp exec(code) do
    {:ok, %BootCode{code: code}}
    |> Stream.iterate(fn {_, prog} -> step(prog) end)
    |> Enum.reduce_while([], &detect/2)
  end

  defp detect({:halt, prog}, _) do
    {:halt, prog.accumulator}
  end

  defp detect({:ok, prog}, positions) do
    if Enum.member?(positions, prog.position) do
      {:halt, :loop}
    else
      {:cont, [prog.position | positions]}
    end
  end
end
