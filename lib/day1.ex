defmodule AOC.Day1 do
  alias AOC.Dataset

  @test_data [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

  def day1 do
    Dataset.read!("data/day3.txt")
    |> Enum.map(&String.to_integer/1)
    |> prepare_windows()
    |> calculate_velocity()
  end

  defp prepare_windows(data, acc \\ []) do
    acc = acc ++ [Enum.take(data, 3) |> Enum.sum()]

    case data do
      data when length(data) == 3 -> acc
      [_head | tail] -> prepare_windows(tail, acc)
    end
  end

  defp calculate_velocity([start_msr | msrs]) do
    Enum.reduce(msrs, {start_msr, 0}, fn next, {prev, v} ->
      {next, adjust_velocity(prev, next, v)}
    end)
    |> elem(1)
  end

  defp adjust_velocity(a, b, v) when b > a, do: v + 1
  defp adjust_velocity(_a, _b, v), do: v
end
