defmodule TestHelper do
  def read_example(name) do
    File.read!("data/examples/#{ name }.txt") |> String.split("\n", trim: true)
  end
end

ExUnit.start()
