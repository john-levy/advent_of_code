defmodule Day3Test do
  use ExUnit.Case
  import Day3
  doctest Day3

  ##############
  # PART 1
  ##############

  def test_input do
    """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end

  test "extracts index of numbers in a row" do
    assert extract_number_indices(String.graphemes("467..114..")) == [[7, 6, 5], [2, 1, 0]]
    assert extract_number_indices(String.graphemes("...*......")) == [[]]
    assert extract_number_indices(String.graphemes("..35..633.")) == [[8, 7, 6], [3, 2]]
    assert extract_number_indices(String.graphemes("......#...")) == [[]]
    assert extract_number_indices(String.graphemes("617*......")) == [[2, 1, 0]]
    assert extract_number_indices(String.graphemes(".....+.58.")) == [[8, 7]]
    assert extract_number_indices(String.graphemes("..592.....")) == [[4, 3, 2]]
    assert extract_number_indices(String.graphemes("......755.")) == [[8, 7, 6]]
    assert extract_number_indices(String.graphemes("...$.*....")) == [[]]
    assert extract_number_indices(String.graphemes(".664.598..")) == [[7, 6, 5], [3, 2, 1]]

    # not included in example... extracts last number correctly 
    assert extract_number_indices(String.graphemes("........57")) == [[9, 8]]
    # not included in example... extracts entire line correctly
    assert extract_number_indices(String.graphemes("1234567890")) == [
             [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
           ]
  end

  test "extracts part number from indicies" do
    assert extract_part_number([7, 6, 5], String.graphemes("467..114..")) == 114
    assert extract_part_number([2, 1, 0], String.graphemes("467..114..")) == 467
  end

  test "returns true if any character in number is adjacent to symbol" do
    matrix = test_input()

    assert !is_part_number([7, 6, 5], 0, matrix)
    assert is_part_number([2, 1, 0], 0, matrix)
    assert is_part_number([8, 7, 6], 2, matrix)
    assert is_part_number([3, 2], 2, matrix)
    assert is_part_number([2, 1, 0], 4, matrix)
    assert !is_part_number([8, 7], 5, matrix)
    assert is_part_number([4, 3, 2], 6, matrix)
    assert is_part_number([8, 7, 6], 7, matrix)
    assert is_part_number([7, 6, 5], 9, matrix)
    assert is_part_number([3, 2, 1], 9, matrix)
  end

  test "evalutes text example correctly" do
    matrix = test_input()

    result =
      Enum.map(matrix, &extract_number_indices/1)
      |> filter_part_numbers(matrix)
      |> extract_part_numbers_by_indices(matrix)
      |> Enum.sum()

    assert result == 4361
  end

  test "evalutes text example correctly with added line where number is last char" do
    matrix = test_input()

    result =
      Enum.map(matrix, &extract_number_indices/1)
      |> filter_part_numbers(matrix)
      |> extract_part_numbers_by_indices(matrix)
      |> Enum.sum()

    assert result == 4361
  end

  test "solution1" do
    assert solution1() == 535_351
  end

  ##############
  # PART 2
  ##############

  test "returns true if adjacent col index is contained in part number indices" do
    assert !is_adjacent([5, 4, 3], 0)
    assert !is_adjacent([5, 4, 3], 1)
    assert is_adjacent([5, 4, 3], 2)
    assert is_adjacent([5, 4, 3], 3)
    assert is_adjacent([5, 4, 3], 4)
    assert is_adjacent([5, 4, 3], 5)
    assert is_adjacent([5, 4, 3], 6)
    assert !is_adjacent([5, 4, 3], 7)
    assert !is_adjacent([5, 4, 3], 8)
    assert !is_adjacent([5, 4, 3], 9)
  end

  test "extracts gear ratio of position in matrix or returns nil if position is not a gear" do
    matrix = test_input()
    part_numbers = Enum.map(matrix, &extract_number_indices/1) |> filter_part_numbers(matrix)
    assert extract_gear_ratio(1, 3, matrix, part_numbers) == 467 * 35
    assert extract_gear_ratio(4, 3, matrix, part_numbers) == nil
    assert extract_gear_ratio(8, 5, matrix, part_numbers) == 755 * 598
  end

  test "evalutes part two example code correctly" do
    matrix = test_input()
    result = extract_gear_ratios(matrix) |> Enum.sum()
    assert result == 467_835
  end

  test "solution2" do
    assert solution2() == 87_287_096
  end
end
