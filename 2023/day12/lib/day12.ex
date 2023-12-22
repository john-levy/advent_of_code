defmodule Day12 do
  @moduledoc """
  Documentation for `Day12`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [record, groups | _] ->
      {record, String.split(groups, ",", trim: true) |> Enum.map(&to_int/1)}
    end)
  end

  def count_valid_arrangements(record, []) do
    case String.contains?(record, "#") do
      true -> 0
      false -> 1
    end
  end

  def count_valid_arrangements(record, [group | rest]) do
    memoized({record, [group | rest]}, fn ->
      # limit search to maximum portion of string that is possible given the remaining groups
      valid_range = String.length(record) - Enum.sum(rest) - Enum.count(rest) - group

      if valid_range < 0 do
        0
      else
        for n <- 0..valid_range, !String.contains?(String.slice(record, 0, n), "#") do
          next = n + group

          # to be valid, the current position + group size must be less than the length of the string, 
          # the current position + group size cannot contain a ".", and the character after the group
          # cannot be a "#" (or the group is at least +1 larger and does not fit the group size)
          if next <= String.length(record) and
               !String.contains?(String.slice(record, n, group), ".") and
               String.at(record, next) != "#" do
            {_, next_record} = String.split_at(record, next + 1)
            count_valid_arrangements(next_record, rest)
          else
            0
          end
        end
        |> Enum.sum()
      end
    end)
  end

  def memoized(key, fun) do
    with nil <- Process.get(key) do
      fun.() |> tap(&Process.put(key, &1))
    end
  end

  def to_int(s) do
    case Integer.parse(s) do
      {n, _} -> n
      :error -> nil
    end
  end

  def solution1() do
    solution1(parse_input(load_file("data/input.txt")))
  end

  def solution1(input) do
    Task.async_stream(
      input,
      fn {record, groups} -> count_valid_arrangements(record, groups) end,
      max_concurrency: 4,
      timeout: :infinity
    )
    |> Enum.map(fn {:ok, result} -> result end)
    |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def unfold_input(input, folds \\ 5)

  def unfold_input({record, groups}, folds) do
    {
      List.duplicate(record, folds) |> Enum.join("?"),
      List.duplicate(groups, folds) |> List.flatten()
    }
  end

  def solution2() do
    solution2(parse_input(load_file("data/input.txt")))
  end

  def solution2(input) do
    solution1(Enum.map(input, &unfold_input/1))
  end
end
