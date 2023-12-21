defmodule Day11 do
  @moduledoc """
  Documentation for `Day11`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def parse_image(input) do
    String.split(input, "\n", trim: true)
    |> Enum.with_index(&parse_row(&1, &2))
    |> Enum.flat_map(& &1)
    |> Map.new()
  end

  def parse_row(entry, row) do
    String.graphemes(entry)
    |> Enum.with_index(fn e, col -> {{row, col}, e} end)
  end

  def find_empty_rows(image) do
    rows = Enum.map(image, fn {{r, _}, _} -> r end) |> Enum.max()
    for n <- 0..rows, is_row_empty(image, n), do: n
  end

  def is_row_empty(image, row_id) do
    Enum.filter(image, fn {{r, _}, _} -> r == row_id end)
    |> Enum.all?(fn {{_, _}, value} -> value == "." end)
  end

  def find_empty_cols(image) do
    cols = Enum.map(image, fn {{_, c}, _} -> c end) |> Enum.max()
    for n <- 0..cols, is_col_empty(image, n), do: n
  end

  def is_col_empty(image, col_id) do
    Enum.filter(image, fn {{_, c}, _} -> c == col_id end)
    |> Enum.all?(fn {{_, _}, value} -> value == "." end)
  end

  def extract_galaxy_locations(image) do
    Enum.filter(image, fn {_, value} -> value == "#" end)
    |> Enum.map(fn {location, _} -> location end)
  end

  def calculate_shortest_path(galaxy1, galaxy2, empty_rows, empty_cols, age \\ 2)

  def calculate_shortest_path({row1, col1}, {row2, col2}, empty_rows, empty_cols, age) do
    expanded_rows = Enum.filter(empty_rows, &(&1 in row1..row2)) |> Enum.count()
    expanded_cols = Enum.filter(empty_cols, &(&1 in col1..col2)) |> Enum.count()

    # calculate nominal distance, remove expanding rows/cols, add expanded rows/cols
    abs(row2 - row1) + abs(col2 - col1) - expanded_rows - expanded_cols + expanded_rows * age +
      expanded_cols * age
  end

  def calculate_shortest_paths(galaxies, empty_rows, empty_cols, age \\ 2, acc \\ [])

  def calculate_shortest_paths([galaxy | rest], empty_rows, empty_cols, age, acc) do
    paths = Enum.map(rest, &calculate_shortest_path(galaxy, &1, empty_rows, empty_cols, age))
    calculate_shortest_paths(rest, empty_rows, empty_cols, age, paths ++ acc)
  end

  def calculate_shortest_paths([], _, _, _, acc) do
    acc
  end

  def solution1() do
    solution1(load_file("data/input.txt"))
  end

  def solution1(input) do
    image = parse_image(input)
    empty_rows = find_empty_rows(image)
    empty_cols = find_empty_cols(image)
    galaxies = extract_galaxy_locations(image)
    calculate_shortest_paths(galaxies, empty_rows, empty_cols) |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def solution2() do
    solution2(load_file("data/input.txt"))
  end

  def solution2(input, age \\ 1_000_000)

  def solution2(input, age) do
    image = parse_image(input)
    empty_rows = find_empty_rows(image)
    empty_cols = find_empty_cols(image)
    galaxies = extract_galaxy_locations(image)
    calculate_shortest_paths(galaxies, empty_rows, empty_cols, age) |> Enum.sum()
  end
end
