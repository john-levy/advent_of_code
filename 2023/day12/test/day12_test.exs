defmodule Day12Test do
  use ExUnit.Case
  doctest Day12
  import Day12

  def input1() do
    """
    #.#.### 1,1,3
    .#...#....###. 1,1,3
    .#.###.#.###### 1,3,1,6
    ####.#...#... 4,1,1
    #....######..#####. 1,6,5
    .###.##....# 3,2,1
    """
  end

  def input2() do
    """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """
  end

  ##############
  # PART 1
  ##############

  test "parses input to list of {springs, contiguous damaged springs}" do
    input = """
    #.#.### 1,1,3
    ####.#...#... 4,1,1
    """

    assert parse_input(input) == [{"#.#.###", [1, 1, 3]}, {"####.#...#...", [4, 1, 1]}]
  end

  test "counts possible ways to solve a record" do
    assert count_valid_arrangements("???.###", [1, 1, 3]) == 1
    assert count_valid_arrangements("????.#...#...", [4, 1, 1]) == 1
    assert count_valid_arrangements("?#?#?#?#?#?#?#?", [1, 3, 1, 6]) == 1
    assert count_valid_arrangements(".??..??...?##.", [1, 1, 3]) == 4
    assert count_valid_arrangements("????.######..#####.", [1, 6, 5]) == 4
    assert count_valid_arrangements("?###????????", [3, 2, 1]) == 10
  end

  test "calculates part 1 example correctly" do
    assert solution1(parse_input(input2())) == 21
  end

  test "solution1" do
    assert solution1() == 7674
  end

  ##############
  # PART 2
  ##############

  test "it can unfold input" do
    assert unfold_input({"???.###", [1, 1, 3]}) ==
             {"???.###????.###????.###????.###????.###",
              [1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 3]}
  end

  test "calculates part 2 example correctly" do
    assert solution2(parse_input(input2())) == 525_152
  end

  test "solution2" do
    assert solution2() == 4_443_895_258_186
  end
end
