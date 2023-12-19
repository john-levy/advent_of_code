defmodule Day10 do
  @moduledoc """
  Documentation for `Day10`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  # elixir lists are not a great data structure to represent 2d arrays, 
  # attempt to use map where key is x,y index and value is tile
  # parse sketch into map where {x,y} tuple is key, value is tile
  def parse_sketch(input) do
    String.split(input, "\n", trim: true)
    |> Enum.with_index(&parse_row(&1, &2))
    |> Enum.flat_map(& &1)
    |> Map.new()
  end

  def parse_row(entry, row) do
    String.graphemes(entry)
    |> Enum.with_index(fn e, col -> {{row, col}, e} end)
  end

  def find_start(sketch) do
    {index, _} = Enum.find(sketch, fn {_, value} -> value == "S" end)
    index
  end

  def trace_loop(sketch) do
    start = find_start(sketch)
    next = next_index(start, sketch)
    trace_loop(next, start, sketch, 1)
  end

  def trace_loop(index, previous, sketch, acc) do
    tile = Map.fetch!(sketch, index)

    if tile == "S" do
      acc
    else
      next = next_index(index, previous, sketch)
      trace_loop(next, index, sketch, acc + 1)
    end
  end

  def next_index({row, col}, sketch) do
    cond do
      tile(sketch, {row - 1, col}) in ["|", "7", "F"] -> {row - 1, col}
      tile(sketch, {row + 1, col}) in ["|", "L", "J"] -> {row + 1, col}
      tile(sketch, {row, col + 1}) in ["-", "7", "J"] -> {row, col + 1}
      true -> {row, col - 1}
    end
  end

  def next_index({row, col}, {p_row, p_col}, sketch) do
    tile = Map.fetch!(sketch, {row, col})

    case tile do
      "|" ->
        if p_row < row do
          {row + 1, col}
        else
          {row - 1, col}
        end

      "7" ->
        if p_row > row do
          {row, col - 1}
        else
          {row + 1, col}
        end

      "F" ->
        if p_row > row do
          {row, col + 1}
        else
          {row + 1, col}
        end

      "-" ->
        if p_col < col do
          {row, col + 1}
        else
          {row, col - 1}
        end

      "L" ->
        if p_row < row do
          {row, col + 1}
        else
          {row - 1, col}
        end

      "J" ->
        if p_row < row do
          {row, col - 1}
        else
          {row - 1, col}
        end
    end
  end

  def tile(map, {row, col}) do
    case Map.fetch(map, {row, col}) do
      {:ok, tile} -> tile
      :error -> nil
    end
  end

  def solution1() do
    solution1(load_file("data/input.txt"))
  end

  def solution1(input) do
    div(trace_loop(parse_sketch(input)), 2)
  end

  ##############
  # PART 2
  ##############

  def define_loop(sketch) do
    start = find_start(sketch)
    next = next_index(start, sketch)

    define_loop(next, start, sketch, [{start, "S"}])
    |> Map.new()
  end

  def define_loop(index, previous, sketch, acc) do
    tile = Map.fetch!(sketch, index)

    if tile == "S" do
      acc
    else
      next = next_index(index, previous, sketch)
      define_loop(next, index, sketch, [{index, tile} | acc])
    end
  end

  def is_enclosed(loop, {row, col}) do
    walls =
      for n <- 0..col,
          is_edge(loop, {row, n}),
          do: 1

    sum = Enum.sum(walls)
    sum != 0 && rem(Enum.sum(walls), 2) != 0
  end

  def is_edge(loop, {row, col}) do
    # this could also be |, S, L, J... just need to pick one or the other:w
    tile(loop, {row, col}) in ["|", "S", "7", "F"]
  end

  def calculate_area(sketch) do
    keys = Map.keys(sketch)
    rows = Enum.map(keys, fn {r, _} -> r end) |> Enum.max()
    cols = Enum.map(keys, fn {_, c} -> c end) |> Enum.max()
    loop = define_loop(sketch)
    calculate_area({0, 0}, loop, rows, cols)
  end

  def calculate_area(index, loop, rows, cols, acc \\ 0)

  def calculate_area({row, col}, loop, rows, cols, acc) when col >= cols do
    calculate_area({row + 1, 0}, loop, rows, cols, acc)
  end

  def calculate_area({row, _}, _, rows, _, acc) when row >= rows do
    acc
  end

  def calculate_area({row, col}, loop, rows, cols, acc) do
    cond do
      Map.fetch(loop, {row, col}) != :error ->
        calculate_area({row, col + 1}, loop, rows, cols, acc)

      is_enclosed(loop, {row, col}) ->
        calculate_area({row, col + 1}, loop, rows, cols, acc + 1)

      true ->
        calculate_area({row, col + 1}, loop, rows, cols, acc)
    end
  end

  def solution2() do
    solution2(load_file("data/input.txt"))
  end

  def solution2(input) do
    calculate_area(parse_sketch(input))
  end
end
