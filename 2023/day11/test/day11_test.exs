defmodule Day11Test do
  use ExUnit.Case
  doctest Day11
  import Day11

  def input1() do
    """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """
  end

  ##############
  # PART 1
  ##############

  test "parses input to map of index -> value" do
    input = """
    ...
    .#.
    ...
    """

    assert parse_image(input) == %{
             {0, 0} => ".",
             {0, 1} => ".",
             {0, 2} => ".",
             {1, 0} => ".",
             {1, 1} => "#",
             {1, 2} => ".",
             {2, 0} => ".",
             {2, 1} => ".",
             {2, 2} => "."
           }
  end

  test "finds empty row ids" do
    assert find_empty_rows(parse_image(input1())) == [3, 7]
  end

  test "finds empty column ids" do
    assert find_empty_cols(parse_image(input1())) == [2, 5, 8]
  end

  test "extracts galaxy locations" do
    assert extract_galaxy_locations(parse_image(input1())) ==
             [{6, 9}, {5, 1}, {1, 7}, {8, 7}, {9, 0}, {9, 4}, {4, 6}, {2, 0}, {0, 3}]
  end

  test "calculates the min distance between two indices" do
    assert calculate_shortest_path({1, 7}, {0, 3}, [], []) == 5
    assert calculate_shortest_path({5, 1}, {2, 0}, [3, 7], [2, 5, 8]) == 5
    assert calculate_shortest_path({8, 7}, {0, 3}, [3, 7], [2, 5, 8]) == 15
    assert calculate_shortest_path({6, 9}, {2, 0}, [3, 7], [2, 5, 8]) == 17
    assert calculate_shortest_path({9, 0}, {9, 4}, [3, 7], [2, 5, 8]) == 5
  end

  test "calculates part 1 example sum correctly" do
    assert solution1(input1()) == 374
  end

  test "solution1" do
    assert solution1() == 9_769_724
  end

  ##############
  # PART 2
  ##############

  test "calculates part 2 example sum correctly" do
    assert solution2(input1(), 10) == 1030
    assert solution2(input1(), 100) == 8410
  end

  test "solution2" do
    assert solution2() == 603_020_563_700
  end
end
