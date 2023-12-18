defmodule Day9 do
  @moduledoc """
  Documentation for `Day9`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def calculate_difference_at_each_step([first | remaining]) do
    calculate_difference_at_each_step(first, remaining, [])
  end

  def calculate_difference_at_each_step(prev, [next | remaining], acc) do
    calculate_difference_at_each_step(next, remaining, [next - prev | acc])
  end

  def calculate_difference_at_each_step(_, [], acc) do
    acc
  end

  def calculate_differences(history) do
    calculate_differences(history, [Enum.reverse(history)])
  end

  def calculate_differences(history, acc) do
    differences = calculate_difference_at_each_step(history)

    if Enum.all?(differences, &(&1 == 0)) do
      acc
    else
      calculate_differences(Enum.reverse(differences), [differences | acc])
    end
  end

  def extrapolate_history(history) do
    calculate_differences(history) |> Enum.map(&List.first/1) |> Enum.sum()
  end

  def to_int_list(input) do
    String.split(input, " ", trim: true) |> Enum.map(&to_int/1)
  end

  def to_int(input) do
    case Integer.parse(input) do
      {number, _} -> number
      :error -> :error
    end
  end

  def solution1() do
    solution1(load_file("data/input.txt"))
  end

  def solution1(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&to_int_list/1)
    |> Enum.map(&extrapolate_history/1)
    |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def extrapolate_backwards(history) do
    calculate_differences(history)
    |> Enum.map(&List.last/1)
    |> extrapolate_backwards([0])
    |> List.first()
  end

  def extrapolate_backwards([first | remaining], acc) do
    extrapolate_backwards(remaining, [first - List.first(acc) | acc])
  end

  def extrapolate_backwards([], acc) do
    acc
  end

  def solution2() do
    solution2(load_file("data/input.txt"))
  end

  def solution2(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&to_int_list/1)
    |> Enum.map(&extrapolate_backwards/1)
    |> Enum.sum()
  end
end
