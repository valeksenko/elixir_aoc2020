defmodule AoC2020.Day08.BootCode do
  defmodule Instruction do
    @enforce_keys [:op, :argument]
    defstruct @enforce_keys
  end

  defstruct accumulator: 0, code: [], position: 0

  def step(prog) do
    prog |> next |> exec_next(prog)
  end

  def next(prog) do
    Enum.fetch(prog.code, prog.position)
  end

  def exec_next({:ok, op}, prog) do
    {:ok, exec_op(op, prog)}
  end

  def exec_next(:error, prog) do
    {:halt, prog}
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
