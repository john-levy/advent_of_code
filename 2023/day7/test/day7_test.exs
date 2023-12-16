defmodule Day7Test do
  use ExUnit.Case
  doctest Day7
  import Day7

  def get_input() do
    """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """
  end

  ##############
  # PART 1
  ##############

  test "parses input into hands and bids" do
    assert parse_input_to_hands_and_bids(get_input()) == [
             ["32T3K", "765"],
             ["T55J5", "684"],
             ["KK677", "28"],
             ["KTJJT", "220"],
             ["QQQJA", "483"]
           ]
  end

  test "groups cards and maps to total of each card" do
    assert group_hand("AAAAA") == [5]
    assert group_hand("AAAA5") == [4, 1]
    assert group_hand("AAA55") == [3, 2]
    assert group_hand("AAA45") == [3, 1, 1]
    assert group_hand("AA345") == [2, 1, 1, 1]
    assert group_hand("A2345") == [1, 1, 1, 1, 1]
  end

  test "compares string based on card rank" do
    assert compare_second_ordering(String.graphemes("A"), String.graphemes("K"))
    assert compare_second_ordering(String.graphemes("AK"), String.graphemes("AQ"))
    assert compare_second_ordering(String.graphemes("AAK"), String.graphemes("AAQ"))
  end

  test "compares part 1 example data entries correctly" do
    assert parse_input_to_hands_and_bids(get_input())
           |> Enum.sort(&compare_entry/2) ==
             [
               ["QQQJA", "483"],
               ["T55J5", "684"],
               ["KK677", "28"],
               ["KTJJT", "220"],
               ["32T3K", "765"]
             ]
  end

  test "calculates part 1 total winnings correctly" do
    assert solution1(get_input()) == 6440
  end

  test "solution1" do
    assert solution1() == 246_163_188
  end

  ##############
  # PART 2
  ##############

  test "groups cards and maps to total of each card, adding joker where it helps the most" do
    assert group_hand_j("AAAAJ") == [5]
    assert group_hand_j("AAAJ5") == [4, 1]
    assert group_hand_j("AAJ55") == [3, 2]
    assert group_hand_j("AAJ45") == [3, 1, 1]
    assert group_hand_j("AJ345") == [2, 1, 1, 1]
    assert group_hand_j("JJJJJ") == [5]
  end

  test "compares part 2 example data entries correctly" do
    assert parse_input_to_hands_and_bids(get_input())
           |> Enum.sort(&compare_entry_j/2) ==
             [
               ["KTJJT", "220"],
               ["QQQJA", "483"],
               ["T55J5", "684"],
               ["KK677", "28"],
               ["32T3K", "765"]
             ]
  end

  test "calculates part 2 total winnings correctly" do
    assert solution2(get_input()) == 5905
  end

  test "solution2" do
    assert solution2() == 245_794_069
  end
end
