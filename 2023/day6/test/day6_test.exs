defmodule Day6Test do
  use ExUnit.Case
  doctest Day6
  import Day6

  def get_input() do
    """
    Time:      7  15   30
    Distance:  9  40  200
    """
  end

  ##############
  # PART 1
  ##############

  test "calculates possible ways to win a race" do
    assert possible_wins_for_race(7, 9, 0, 0) == 4
  end

  test "calculate part 1 example correctly" do
    races =
      String.split(get_input(), "\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))

    [_t | times] = Enum.at(races, 0)
    [_d | distances] = Enum.at(races, 1)

    assert calculate_possible_wins(
             times |> Enum.map(&to_int/1),
             distances |> Enum.map(&to_int/1),
             []
           )
           |> Enum.reduce(&(&1 * &2)) == 288
  end

  test "part 1 solution" do
    assert solution1() == 800_280
  end

  ##############
  # PART 2
  ##############

  test "calculate part 2 example correctlY" do
    races =
      String.split(get_input(), "\n", trim: true)
      |> Enum.map(&String.replace(&1, " ", ""))
      |> Enum.map(&String.split(&1, ":", trim: true))

    [_t | times] = Enum.at(races, 0)
    [_d | distances] = Enum.at(races, 1)

    assert calculate_possible_wins(
             times |> Enum.map(&to_int/1),
             distances |> Enum.map(&to_int/1),
             []
           )
           |> Enum.sum() == 71503
  end

  test "part 2 solution" do
    assert solution2() == 45_128_024
  end
end
