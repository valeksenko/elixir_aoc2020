defmodule AoC2020.Day08.BootCode do
  defmodule Instruction do
    @enforce_keys [:op, :argument]
    defstruct @enforce_keys
  end

  defstruct [accumulator: 0, code: [], position: 0]

  def step(prog) do
    prog |> current |> exec_op(prog)
  end

  def current(prog) do
    Enum.fetch!(prog.code, prog.position)
  end

  def exec_op(%Instruction{op: "nop"}, prog) do
    %{prog | position: prog.position + 1}
  end

  def exec_op(%Instruction{op: "acc", argument: argument}, prog) do
    %{prog | position: prog.position + 1, accumulator: prog.accumulator + argument}
  end

  def exec_op(%Instruction{op: "jmp", argument: argument}, prog) do
    %{prog | position: prog.position + argument}
  end
end
