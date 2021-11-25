defmodule AoC2020.Day08.Part1 do
  import AoC2020.Day08.Parser
  import AoC2020.Day08.BootCode
  alias AoC2020.Day08.BootCode

  @behaviour AoC2020.Day

  @impl AoC2020.Day
  def run(data) do
    data
    |> code_parser
    |> exec
  end

  defp exec(code) do
    %BootCode{code: code}
    |> Stream.iterate(&step/1)
    |> Enum.reduce_while({0, []}, &detect/2)
  end

  defp detect(prog, {accumulator, positions}) do
    if Enum.member?(positions, prog.position) do
      {:halt, accumulator}
    else
      {:cont, {prog.accumulator, [prog.position | positions]}}
    end
  end
end
