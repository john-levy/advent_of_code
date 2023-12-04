defmodule Day1Test do
  use ExUnit.Case
  import Day1
  doctest Day1

  ##############
  # PART 1
  ##############

  test "extracts first digit from string" do
    assert find_first_digit("1abc2") == "1"
    assert find_first_digit("pqr3stu8vwx") == "3"
    assert find_first_digit("a1b2c3d4e5f") == "1"
    assert find_first_digit("treb7uchet") == "7"
  end

  test "extracts last digit from string" do
    assert find_last_digit("1abc2") == "2"
    assert find_last_digit("pqr3stu8vwx") == "8"
    assert find_last_digit("a1b2c3d4e5f") == "5"
    assert find_last_digit("treb7uchet") == "7"
  end

  test "extracts first and last digit from string as a integer" do
    assert concat_first_and_last_digit_as_integer("1abc2") == 12
    assert concat_first_and_last_digit_as_integer("pqr3stu8vwx") == 38
    assert concat_first_and_last_digit_as_integer("a1b2c3d4e5f") == 15
    assert concat_first_and_last_digit_as_integer("treb7uchet") == 77
  end

  test "solution 1 example cases" do
    assert concat_first_and_last_digit_as_integer("1abc2") == 12
    assert concat_first_and_last_digit_as_integer("pqr3stu8vwx") == 38
    assert concat_first_and_last_digit_as_integer("a1b2c3d4e5f") == 15
    assert concat_first_and_last_digit_as_integer("treb7uchet") == 77
  end

  test "solution 1 example sum" do
    result =
      "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet"
      |> String.split("\n")
      |> Enum.map(&concat_first_and_last_digit_as_integer/1)
      |> Enum.sum()

    assert ^result = 142
  end

  test "solution1" do
    assert solution1() == 54450
  end

  ##############
  # PART 2
  ##############

  test "extracts first number from string" do
    assert find_first_number("two1nine") == "2"
    assert find_first_number("eightwothree") == "8"
    assert find_first_number("abcone2threexyz") == "1"
    assert find_first_number("xtwone3four") == "2"
    assert find_first_number("4nineeightseven2") == "4"
    assert find_first_number("zoneight234") == "1"
    assert find_first_number("7pqrstsixteen") == "7"
  end

  test "extracts last number from string" do
    assert find_last_number("two1nine") == "9"
    assert find_last_number("eightwothree") == "3"
    assert find_last_number("abcone2threexyz") == "3"
    assert find_last_number("xtwone3four") == "4"
    assert find_last_number("4nineeightseven2") == "2"
    assert find_last_number("zoneight234") == "4"
    assert find_last_number("7pqrstsixteen") == "6"
  end

  test "solution 2 example cases" do
    assert concat_first_and_last_number_as_integer("two1nine") == 29
    assert concat_first_and_last_number_as_integer("eightwothree") == 83
    assert concat_first_and_last_number_as_integer("abcone2threexyz") == 13
    assert concat_first_and_last_number_as_integer("xtwone3four") == 24
    assert concat_first_and_last_number_as_integer("4nineeightseven2") == 42
    assert concat_first_and_last_number_as_integer("zoneight234") == 14
    assert concat_first_and_last_number_as_integer("7pqrstsixteen") == 76
  end

  test "solution 2 example sum" do
    result =
      "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen"
      |> String.split("\n")
      |> Enum.map(&concat_first_and_last_number_as_integer/1)
      |> Enum.sum()

    assert ^result = 281
  end

  test "solution2" do
    assert solution2() == 54265
  end
end
