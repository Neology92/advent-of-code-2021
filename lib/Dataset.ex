defmodule AOC.Dataset do
  def read!(path) do
    case File.read(path) do
      {:ok, content} ->
        String.split(content, "\n")
        |> Enum.reject(&(&1 == ""))

      {:error, reason} ->
        raise "File read: #{reason}"
    end
  end
end
