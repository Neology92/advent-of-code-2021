defmodule AOC.Day2 do
  @test_data [00100, 11110, 10110, 10111, 10101, 01111, 00111, 11100, 10000, 11001, 00010, 01010]

  defmacro __using__(_) do
    quote do
      import AOC.Day2

      def day2 do
        generate_rates(@test_data)
      end
    end
  end

  def generate_rates(input) do
    List.zip([input, input])
  end
end
