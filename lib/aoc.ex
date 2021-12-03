defmodule AOC do
  alias AOC.Dataset
  # use AOC.Day1
  # use AOC.Day2

  @test_data [
    "00100",
    "11110",
    "10110",
    "10111",
    "10101",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010"
  ]

  def main do
    Dataset.read!("data/day3.txt")
    |> generate_rates
  end

  def generate_rates(input) do
    input
    |> Enum.map(&String.split(&1, "", trim: true))
    |> transpose
    |> Enum.map(&find_gamma_for_column/1)
    |> List.zip()
    |> Enum.map(&transform_bin_to_integer/1)
    |> Enum.product()
  end

  def find_gamma_for_column(column) do
    Enum.reduce(column, {0, 0}, fn
      value, {zeros, ones} when value == "0" -> {zeros + 1, ones}
      value, {zeros, ones} when value == "1" -> {zeros, ones + 1}
    end)
    |> calculate_gamma_and_epsilon
  end

  def calculate_gamma_and_epsilon({zeros, ones}) when zeros < ones, do: {"1", "0"}
  def calculate_gamma_and_epsilon({zeros, ones}) when zeros > ones, do: {"0", "1"}

  def transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def transform_bin_to_integer(tuple) do
    tuple |> Tuple.to_list() |> Enum.join("") |> String.to_integer(2)
  end
end
