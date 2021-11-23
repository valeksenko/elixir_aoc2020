defmodule Mix.Tasks.Day do
  use Mix.Task

  @shortdoc "Run a spefic day with its input"

  def run([day, part | opts]) do
    module =
      Module.safe_concat(~w[ Elixir AoC2020 Day#{String.pad_leading(day, 2, "0")} Part#{part} ])

    case File.read("data/day#{String.pad_leading(day, 2, "0")}.txt") do
      {:ok, content} ->
        apply(module, :run, [content |> String.split("\n", trim: !Enum.member?(opts, "notrim"))])

      {:error, _} ->
        apply(module, :run, [[]])
    end
    |> IO.puts()
  end
end
