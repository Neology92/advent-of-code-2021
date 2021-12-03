defmodule AOC.Day3 do
  alias AOC.Dataset

  @test_data [
    "00100",
    "11110",
    "10101",
    "10110",
    "10111",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010"
  ]

  def day3 do
    Dataset.read!("data/day3.txt")
    |> generate_rates
  end

  defp generate_rates(input) do
    input
    |> Enum.map(&String.split(&1, "", trim: true))
    |> transpose
    |> Enum.map(&find_gamma_for_column/1)
    |> List.zip()
    |> Enum.map(&transform_bin_to_integer/1)
    |> Enum.product()
  end

  defp find_gamma_for_column(column) do
    Enum.reduce(column, {0, 0}, fn
      value, {zeros, ones} when value == "0" -> {zeros + 1, ones}
      value, {zeros, ones} when value == "1" -> {zeros, ones + 1}
    end)
    |> calculate_gamma_and_epsilon
  end

  defp calculate_gamma_and_epsilon({zeros, ones}) when zeros < ones, do: {"1", "0"}
  defp calculate_gamma_and_epsilon({zeros, ones}) when zeros > ones, do: {"0", "1"}

  defp transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp transform_bin_to_integer(tuple) do
    tuple |> Tuple.to_list() |> Enum.join("") |> String.to_integer(2)
  end
end
