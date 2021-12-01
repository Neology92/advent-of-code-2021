defmodule AOC do
  @moduledoc """
  Documentation for `AOC`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AOC.hello()
      :world

  """
  @data [
    199,
    200,
    208,
    210,
    200,
    207,
    240,
    269,
    260,
    263
  ]

  def main do
    case File.read("dataset.txt") do
      {:ok, content} ->
        String.split(content, "\n")
        |> Enum.reject(&(&1 == ""))
        |> Enum.map(&String.to_integer/1)
        |> prepare_windows()
        |> calculate_velocity

      {:error, reason} ->
        IO.puts("error: #{reason}")
    end

    # prepare_windows(@data)
    # |> calculate_velocity()
  end

  def prepare_windows(data, acc \\ []) do
    acc = acc ++ [Enum.take(data, 3) |> Enum.sum()]

    case data do
      data when length(data) == 3 -> acc
      [_head | tail] -> prepare_windows(tail, acc)
    end
  end

  def calculate_velocity([start_msr | msrs]) do
    Enum.reduce(msrs, {start_msr, 0}, fn next, {prev, v} ->
      {next, adjust_velocity(prev, next, v)}
    end)
    |> elem(1)
  end

  def adjust_velocity(a, b, v) when b > a, do: v + 1
  def adjust_velocity(_a, _b, v), do: v
end
