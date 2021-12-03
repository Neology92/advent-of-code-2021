defmodule Imports do
  defmacro __using__(_) do
    quote do
      import AOC.Day1
      import AOC.Day3
    end
  end
end
