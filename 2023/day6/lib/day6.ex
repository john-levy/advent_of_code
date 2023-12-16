defmodule Day6 do
  @moduledoc """
  Documentation for `Day6`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def possible_wins_for_race(time, record, hold, acc) when hold <= time do
    cond do
      hold * (time - hold) > record -> possible_wins_for_race(time, record, hold + 1, acc + 1)
      true -> possible_wins_for_race(time, record, hold + 1, acc)
    end
  end

  def possible_wins_for_race(_, _, _, acc) do
    acc
  end

  def calculate_possible_wins([time | times], [distance | distance_records], acc) do
    possible_wins = possible_wins_for_race(time, distance, 0, 0)
    calculate_possible_wins(times, distance_records, [possible_wins | acc])
  end

  def calculate_possible_wins([], [], acc) do
    acc
  end

  def to_int(s) do
    case Integer.parse(s) do
      {num, _} -> num
      :error -> :error
    end
  end

  def solution1 do
    races =
      load_file("data/input.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))

    [_t | times] = Enum.at(races, 0)
    [_d | distances] = Enum.at(races, 1)

    calculate_possible_wins(times |> Enum.map(&to_int/1), distances |> Enum.map(&to_int/1), [])
    |> Enum.reduce(&(&1 * &2))
  end

  ##############
  # PART 2
  ##############

  def solution2 do
    races =
      load_file("data/input.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.replace(&1, " ", ""))
      |> Enum.map(&String.split(&1, ":", trim: true))

    [_t | times] = Enum.at(races, 0)
    [_d | distances] = Enum.at(races, 1)

    calculate_possible_wins(times |> Enum.map(&to_int/1), distances |> Enum.map(&to_int/1), [])
    |> Enum.fetch!(0)
  end
end
