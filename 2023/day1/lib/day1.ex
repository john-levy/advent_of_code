defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def find_first_digit(input) do
    {first, rest} = String.split_at(input, 1)

    case Integer.parse(first) do
      {_, _} -> first
      :error -> find_first_digit(rest)
    end
  end

  def find_last_digit(input) do
    find_last_digit(input, -1)
  end

  def find_last_digit(input, index) do
    {_, sub} = String.split_at(input, index)
    {first, _} = String.split_at(sub, 1)

    case Integer.parse(first) do
      {_, _} -> first
      :error -> find_last_digit(input, index - 1)
    end
  end

  def concat_first_and_last_digit_as_integer(input) do
    String.to_integer(find_first_digit(input) <> find_last_digit(input))
  end

  def solution1 do
    load_file("data/input.txt")
    |> String.split("\n")
    |> Enum.map(&concat_first_and_last_digit_as_integer/1)
    |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def find_first_number(input) do
    {first, rest} = String.split_at(input, 1)

    case Integer.parse(first) do
      {_, _} ->
        first

      :error ->
        case replace_text_number_with_digit(input) do
          :error -> find_first_number(rest)
          digit -> digit
        end
    end
  end

  def find_last_number(input) do
    find_last_number(input, -1)
  end

  def find_last_number(input, index) do
    {_, sub} = String.split_at(input, index)
    {first, _} = String.split_at(sub, 1)

    case Integer.parse(first) do
      {_, _} ->
        first

      :error ->
        case replace_text_number_with_digit(sub) do
          :error -> find_last_number(input, index - 1)
          digit -> digit
        end
    end
  end

  def replace_text_number_with_digit(input) do
    cond do
      String.starts_with?(input, "one") -> "1"
      String.starts_with?(input, "two") -> "2"
      String.starts_with?(input, "three") -> "3"
      String.starts_with?(input, "four") -> "4"
      String.starts_with?(input, "five") -> "5"
      String.starts_with?(input, "six") -> "6"
      String.starts_with?(input, "seven") -> "7"
      String.starts_with?(input, "eight") -> "8"
      String.starts_with?(input, "nine") -> "9"
      true -> :error
    end
  end

  def concat_first_and_last_number_as_integer(input) do
    String.to_integer(find_first_number(input) <> find_last_number(input))
  end

  def solution2 do
    load_file("data/input.txt")
    |> String.split("\n")
    |> Enum.map(&concat_first_and_last_number_as_integer/1)
    |> Enum.sum()
  end
end
