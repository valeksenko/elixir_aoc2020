defmodule TestHelper do
  def read_example(name, trim \\ true) do
    File.read!("data/examples/#{name}.txt") |> String.split("\n", trim: trim)
  end
end

ExUnit.start()
