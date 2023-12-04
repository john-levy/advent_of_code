defmodule Day2Test do
  use ExUnit.Case
  import Day2
  doctest Day2

  ##############
  # PART 1
  ##############

  test "parses game id" do
    assert parse_game_id("Game 1") == 1
    assert parse_game_id("Game 2") == 2
    assert parse_game_id("Game 20") == 20
  end

  test "parses handful rgb tuple" do
    assert parse_handful("3 blue, 4 red") == {4, 0, 3}
  end

  test "parse game" do
    assert parse_game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green") ==
             {1, %{red: 4, green: 2, blue: 6}}

    assert parse_game("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue") ==
             {2, %{red: 1, green: 3, blue: 4}}

    assert parse_game("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red") ==
             {3, %{red: 20, green: 13, blue: 6}}

    assert parse_game("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red") ==
             {4, %{red: 14, green: 3, blue: 15}}

    assert parse_game("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green") ==
             {5, %{red: 6, green: 3, blue: 2}}
  end

  test "determines whether a game is possible" do
    assert possible(parse_game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"))

    assert possible(
             parse_game("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")
           )

    assert !possible(
             parse_game(
               "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
             )
           )

    assert !possible(
             parse_game(
               "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
             )
           )

    assert possible(parse_game("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"))
  end

  test "solution1" do
    assert solution1() == 2331
  end

  ##############
  # PART 2
  ##############

  test "solution2" do
    assert solution2() == 71585
  end
end
