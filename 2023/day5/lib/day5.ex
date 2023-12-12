defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def find_mapping(value, [entry | rest]) do
    case map_input_to_output(value, entry) do
      nil -> find_mapping(value, rest)
      mapping -> mapping
    end
  end

  def find_mapping(value, []) do
    value
  end

  def map_input_to_output(value, [output_start, input_start, range])
      when value >= input_start and value <= input_start + range do
    output_start + (value - input_start)
  end

  def map_input_to_output(_value, [_, _, _]) do
    nil
  end

  def parse_maps(maps) do
    Enum.map(maps, fn e -> String.split(e, "\n", trim: true) end)
    |> Enum.map(fn e -> Enum.map(e, &parse_map_entry/1) end)
  end

  def parse_map_entry(entry) do
    String.split(entry, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def map_location_number(seed, maps) do
    Enum.reduce(maps, seed, fn map, acc -> find_mapping(acc, map) end)
  end

  def solution1() do
    [seeds | rest] =
      load_file("data/input.txt")
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn e -> String.split(e, ":", trim: true) end)
      |> Enum.map(fn [_, map] -> map end)

    maps = parse_maps(rest)

    String.split(seeds, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn e -> map_location_number(e, maps) end)
    |> Enum.min()
  end

  ##############
  # PART 2
  ##############

  def parse_seed_ranges(seed_ranges) do
    split = String.split(seed_ranges, " ", trim: true) |> Enum.map(&String.to_integer/1)
    parse_seed_ranges(split, [])
  end

  def parse_seed_ranges([start | rest], acc) do
    [length | rest] = rest
    parse_seed_ranges(rest, [{start, length} | acc])
  end

  def parse_seed_ranges([], acc) do
    acc
  end

  def find_location_number_for_range(start, offset, maps) do
    location = map_location_number(start + offset, maps)
    find_location_number_for_range(start, offset - 1, maps, location)
  end

  def find_location_number_for_range(_start, offset, _maps, acc) when offset < 0 do
    acc
  end

  def find_location_number_for_range(start, offset, maps, acc) do
    location = map_location_number(start + offset, maps)

    if location < acc do
      find_location_number_for_range(start, offset - 1, maps, location)
    else
      find_location_number_for_range(start, offset - 1, maps, acc)
    end
  end

  def solution2() do
    [seed_ranges | rest] =
      load_file("data/input.txt")
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn e -> String.split(e, ":", trim: true) end)
      |> Enum.map(fn [_, map] -> map end)

    seeds = parse_seed_ranges(seed_ranges)
    maps = parse_maps(rest)

    Task.async_stream(
      seeds,
      fn {start, length} ->
        find_location_number_for_range(start, length, maps)
      end,
      max_concurrency: 4,
      timeout: :infinity
    )
    |> Enum.map(fn {:ok, result} -> result end)
    |> Enum.min()
  end
end
