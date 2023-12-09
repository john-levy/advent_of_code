defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  # parses lines of input into 2d list "matrix" of characters
  def parse_input_to_matrix(input) do
    String.split(input, "\n") |> Enum.map(&String.graphemes/1)
  end

  # parses row of matrix into a list of "numbers", each number is a list of all column
  # indices that the number occupies
  def extract_number_indices(row) do
    extract_number_indices(row, 0, [[]])
  end

  def extract_number_indices(row, index, acc) do
    cond do
      index >= Enum.count(row) ->
        acc

      is_digit(Enum.at(row, index)) ->
        [head | tail] = acc

        if head == [] || hd(head) == index - 1 do
          # append index to current number
          extract_number_indices(row, index + 1, [[index | head] | tail])
        else
          # create list for new number
          extract_number_indices(row, index + 1, [[index] | acc])
        end

      true ->
        extract_number_indices(row, index + 1, acc)
    end
  end

  # remove entries from indices list if they are not part numbers
  def filter_part_numbers(indices, matrix) do
    Enum.with_index(indices, fn e, index -> filter_part_numbers(e, index, matrix) end)
  end

  def filter_part_numbers(indicies, row_index, matrix) do
    for e <- indicies, is_part_number(e, row_index, matrix), do: e
  end

  def is_part_number(number, row_index, matrix) when is_list(number) do
    adjacent = for e <- number, is_part_number(row_index, e, matrix), do: e
    Enum.count(adjacent) > 0
  end

  def is_part_number(row_index, col_index, matrix) do
    is_symbol(matrix_at(matrix, row_index - 1, col_index - 1)) ||
      is_symbol(matrix_at(matrix, row_index - 1, col_index)) ||
      is_symbol(matrix_at(matrix, row_index - 1, col_index + 1)) ||
      is_symbol(matrix_at(matrix, row_index, col_index - 1)) ||
      is_symbol(matrix_at(matrix, row_index, col_index + 1)) ||
      is_symbol(matrix_at(matrix, row_index + 1, col_index - 1)) ||
      is_symbol(matrix_at(matrix, row_index + 1, col_index)) ||
      is_symbol(matrix_at(matrix, row_index + 1, col_index + 1))
  end

  def extract_part_numbers_by_indices(numbers, matrix) do
    Enum.with_index(numbers, fn e, index ->
      extract_part_numbers_from_row(e, Enum.at(matrix, index))
    end)
    |> Enum.flat_map(fn e -> e end)
  end

  def extract_part_numbers_from_row(numbers, row) do
    for n <- numbers, do: extract_part_number(n, row)
  end

  def extract_part_number(number, row) do
    text = for n <- number, do: Enum.at(row, n)

    Enum.reverse(text)
    |> Enum.join("")
    |> String.to_integer()
  end

  def is_digit(char) do
    case Integer.parse(char) do
      {_, _} -> true
      :error -> false
    end
  end

  def is_dot(char) do
    char == "."
  end

  def is_symbol(char) do
    char != nil && !is_digit(char) && !is_dot(char)
  end

  def matrix_at(matrix, row_index, column_index) do
    row = Enum.at(matrix, row_index)

    case row do
      nil -> nil
      _ -> Enum.at(row, column_index)
    end
  end

  def solution1 do
    matrix = parse_input_to_matrix(load_file("data/input.txt"))

    Enum.map(matrix, &extract_number_indices/1)
    |> filter_part_numbers(matrix)
    |> extract_part_numbers_by_indices(matrix)
    |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def extract_gear_ratios(matrix) do
    part_numbers = Enum.map(matrix, &extract_number_indices/1) |> filter_part_numbers(matrix)
    extract_gear_ratios(matrix, 0, 0, part_numbers, [])
  end

  def extract_gear_ratios(matrix, row_index, col_index, part_numbers, acc) do
    row = Enum.at(matrix, row_index)

    cond do
      row == nil ->
        acc

      col_index >= Enum.count(row) ->
        extract_gear_ratios(matrix, row_index + 1, 0, part_numbers, acc)

      is_star(Enum.at(row, col_index)) ->
        case extract_gear_ratio(row_index, col_index, matrix, part_numbers) do
          nil ->
            extract_gear_ratios(matrix, row_index, col_index + 1, part_numbers, acc)

          ratio ->
            extract_gear_ratios(matrix, row_index, col_index + 1, part_numbers, [ratio | acc])
        end

      true ->
        extract_gear_ratios(matrix, row_index, col_index + 1, part_numbers, acc)
    end
  end

  def extract_gear_ratio(row_index, col_index, matrix, part_numbers) do
    previous_row = Enum.at(part_numbers, row_index - 1)
    current_row = Enum.at(part_numbers, row_index)
    next_row = Enum.at(part_numbers, row_index + 1)

    p =
      for e <- previous_row,
          is_adjacent(e, col_index),
          do: extract_part_number(e, Enum.at(matrix, row_index - 1))

    c =
      for e <- current_row,
          is_adjacent(e, col_index),
          do: extract_part_number(e, Enum.at(matrix, row_index))

    n =
      for e <- next_row,
          is_adjacent(e, col_index),
          do: extract_part_number(e, Enum.at(matrix, row_index + 1))

    case Enum.concat(p, Enum.concat(c, n)) do
      [p1, p2] -> p1 * p2
      _ -> nil
    end
  end

  def is_adjacent(part_number_indices, col_index) do
    Enum.member?(part_number_indices, col_index - 1) ||
      Enum.member?(part_number_indices, col_index) ||
      Enum.member?(part_number_indices, col_index + 1)
  end

  def is_star(char) do
    char == "*"
  end

  def solution2 do
    matrix = parse_input_to_matrix(load_file("data/input.txt"))
    extract_gear_ratios(matrix) |> Enum.sum()
  end
end
