defmodule Day7 do
  @moduledoc """
  Documentation for `Day7`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def parse_input_to_hands_and_bids(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  def group_hand(hand) do
    Enum.frequencies(String.graphemes(hand))
    |> Map.values()
    |> Enum.sort(&>=/2)
  end

  def compare_entry(g1, g2) do
    [h1 | _] = g1
    [h2 | _] = g2

    compare_hand(h1, h2)
  end

  def compare_hand(h1, h2) do
    matches1 = group_hand(h1)
    matches2 = group_hand(h2)

    cond do
      matches1 == matches2 -> compare_second_ordering(String.graphemes(h1), String.graphemes(h2))
      true -> matches1 >= matches2
    end
  end

  def compare_second_ordering([char1 | rest1], [char2 | rest2]) do
    score1 = card_score(char1)
    score2 = card_score(char2)

    cond do
      score1 == score2 -> compare_second_ordering(rest1, rest2)
      true -> score1 >= score2
    end
  end

  def compare_second_ordering([], []) do
    true
  end

  def card_score(card) do
    case card do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> 11
      "T" -> 10
      "9" -> 9
      "8" -> 8
      "7" -> 7
      "6" -> 6
      "5" -> 5
      "4" -> 4
      "3" -> 3
      "2" -> 2
    end
  end

  def to_int(s) do
    case Integer.parse(s) do
      {n, _} -> n
      :error -> :error
    end
  end

  def calculate_winnings([_ | b], multiplier) do
    [bid | _] = b
    to_int(bid) * (multiplier + 1)
  end

  def solution1() do
    solution1(load_file("data/input.txt"))
  end

  def solution1(input) do
    parse_input_to_hands_and_bids(input)
    |> Enum.sort(&compare_entry/2)
    |> Enum.reverse()
    |> Enum.with_index(fn e, index -> calculate_winnings(e, index) end)
    |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def group_hand_j(hand) when hand == "JJJJJ" do
    [5]
  end

  def group_hand_j(hand) do
    chars = String.graphemes(hand)
    jokers = Enum.filter(chars, &(&1 == "J")) |> Enum.count()

    [max | rest] =
      Enum.frequencies(Enum.filter(chars, &(&1 != "J")))
      |> Map.values()
      |> Enum.sort(&>=/2)

    [max + jokers | rest]
  end

  def card_score_j(card) do
    case card do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "T" -> 10
      "9" -> 9
      "8" -> 8
      "7" -> 7
      "6" -> 6
      "5" -> 5
      "4" -> 4
      "3" -> 3
      "2" -> 2
      "J" -> 1
    end
  end

  def compare_entry_j(g1, g2) do
    [h1 | _] = g1
    [h2 | _] = g2

    compare_hand_j(h1, h2)
  end

  def compare_hand_j(h1, h2) do
    matches1 = group_hand_j(h1)
    matches2 = group_hand_j(h2)

    cond do
      matches1 == matches2 ->
        compare_second_ordering_j(String.graphemes(h1), String.graphemes(h2))

      true ->
        matches1 >= matches2
    end
  end

  def compare_second_ordering_j([char1 | rest1], [char2 | rest2]) do
    score1 = card_score_j(char1)
    score2 = card_score_j(char2)

    cond do
      score1 == score2 -> compare_second_ordering_j(rest1, rest2)
      true -> score1 >= score2
    end
  end

  def compare_second_ordering_j([], []) do
    true
  end

  def solution2() do
    solution2(load_file("data/input.txt"))
  end

  def solution2(input) do
    parse_input_to_hands_and_bids(input)
    |> Enum.sort(&compare_entry_j/2)
    |> Enum.reverse()
    |> Enum.with_index(fn e, index -> calculate_winnings(e, index) end)
    |> Enum.sum()
  end
end
