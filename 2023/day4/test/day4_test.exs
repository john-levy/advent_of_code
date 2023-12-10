defmodule Day4Test do
  use ExUnit.Case
  doctest Day4
  import Day4

  def test_input do
    """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """
    |> String.split("\n", trim: true)
  end

  test "extracts winning and draw numbers from card" do
    assert split_numbers(Enum.at(test_input(), 0)) ==
             {[41, 48, 83, 86, 17], [83, 86, 6, 31, 17, 9, 48, 53]}

    assert split_numbers(Enum.at(test_input(), 1)) ==
             {[13, 32, 20, 16, 61], [61, 30, 68, 82, 17, 32, 24, 19]}
  end

  test "calulates number of draw wins" do
    assert count_wins(split_numbers(Enum.at(test_input(), 0))) == 4
    assert count_wins(split_numbers(Enum.at(test_input(), 1))) == 2
    assert count_wins(split_numbers(Enum.at(test_input(), 2))) == 2
    assert count_wins(split_numbers(Enum.at(test_input(), 3))) == 1
    assert count_wins(split_numbers(Enum.at(test_input(), 4))) == 0
    assert count_wins(split_numbers(Enum.at(test_input(), 5))) == 0
  end

  test "calculates points from number of wins" do
    assert calculate_points(count_wins(split_numbers(Enum.at(test_input(), 0)))) == 8
    assert calculate_points(count_wins(split_numbers(Enum.at(test_input(), 1)))) == 2
    assert calculate_points(count_wins(split_numbers(Enum.at(test_input(), 2)))) == 2
    assert calculate_points(count_wins(split_numbers(Enum.at(test_input(), 3)))) == 1
    assert calculate_points(count_wins(split_numbers(Enum.at(test_input(), 4)))) == 0
    assert calculate_points(count_wins(split_numbers(Enum.at(test_input(), 5)))) == 0
  end

  test "calculates part1 example points correctly" do
    assert test_input()
           |> Enum.map(&split_numbers/1)
           |> Enum.map(&count_wins/1)
           |> Enum.map(&calculate_points/1)
           |> Enum.sum() == 13
  end

  test "solution1" do
    assert Day4.solution1() == 26346
  end

  ##############
  # PART 2
  ##############
  test "calculates total scratchcards won for a single game" do
    wins =
      test_input()
      |> Enum.map(&split_numbers/1)
      |> Enum.map(&count_wins/1)

    assert process_copies(wins, 0) == 15
    assert process_copies(wins, 1) == 7
  end

  test "calculates part2 example total scratchcards correctly" do
    wins =
      test_input()
      |> Enum.map(&split_numbers/1)
      |> Enum.map(&count_wins/1)

    total =
      Enum.with_index(wins, fn _, index -> process_copies(wins, index) end) |> Enum.sum()

    assert total == 30
  end

  test "solution2" do
    assert Day4.solution2() == 8_467_762
  end
end
