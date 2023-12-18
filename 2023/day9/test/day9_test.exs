defmodule Day9Test do
  use ExUnit.Case
  doctest Day9
  import Day9

  def get_input() do
    """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """
  end

  ##############
  # PART 1
  ##############

  test "calculates difference between each step in a history" do
    assert calculate_difference_at_each_step([0, 3, 6, 9, 12, 15]) == [3, 3, 3, 3, 3]
    assert calculate_difference_at_each_step([1, 3, 6, 10, 15, 21]) == [6, 5, 4, 3, 2]
    assert calculate_difference_at_each_step([10, 13, 16, 21, 30, 45]) == [15, 9, 5, 3, 3]
  end

  test "extrapolates part 1 example histories correctly" do
    assert extrapolate_history([0, 3, 6, 9, 12, 15]) == 18
    assert extrapolate_history([1, 3, 6, 10, 15, 21]) == 28
    assert extrapolate_history([10, 13, 16, 21, 30, 45]) == 68
  end

  test "calculates part 1 example correctly" do
    assert solution1(get_input()) == 114
  end

  test "solution1" do
    assert solution1() == 1_974_232_246
  end

  ##############
  # PART 2
  ##############

  test "extrapolates part 2 example histories backwards correctly" do
    assert extrapolate_backwards([0, 3, 6, 9, 12, 15]) == -3
    assert extrapolate_backwards([1, 3, 6, 10, 15, 21]) == 0
    assert extrapolate_backwards([10, 13, 16, 21, 30, 45]) == 5
  end

  test "calculates part 2 example correctly" do
    assert solution2(get_input()) == 2
  end

  test "solution2" do
    assert solution2() == 928
  end
end
