defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def split_numbers(card) do
    [_, numbers] = String.split(card, ":")
    [winning_numbers, draw] = String.split(numbers, "|")

    {String.split(winning_numbers, " ", trim: true) |> Enum.map(&to_int/1),
     String.split(draw, " ", trim: true) |> Enum.map(&to_int/1)}
  end

  def count_wins({winning_numbers, draw}) do
    Enum.filter(draw, &Enum.member?(winning_numbers, &1)) |> Enum.count()
  end

  def calculate_points(wins) do
    if wins > 0, do: Integer.pow(2, wins - 1), else: 0
  end

  def to_int(int_str) do
    case Integer.parse(int_str) do
      {number, _} -> number
      :error -> nil
    end
  end

  def solution1() do
    load_file("data/input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&split_numbers/1)
    |> Enum.map(&count_wins/1)
    |> Enum.map(&calculate_points/1)
    |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def process_copies(wins, index) do
    case Enum.at(wins, index) do
      0 -> 1
      n -> process_copies(wins, index, Enum.to_list(1..n), 1 + n)
    end
  end

  def process_copies(wins, index, [head | tail], acc) do
    case Enum.at(wins, index + head) do
      0 ->
        process_copies(wins, index, tail, acc)

      n ->
        acc = process_copies(wins, index + head, Enum.to_list(1..n), acc + n)
        process_copies(wins, index, tail, acc)
    end
  end

  def process_copies(_wins, _index, [], acc) do
    acc
  end

  def solution2() do
    wins =
      load_file("data/input.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&split_numbers/1)
      |> Enum.map(&count_wins/1)

    Enum.with_index(wins, fn _, index -> process_copies(wins, index) end) |> Enum.sum()
  end
end
