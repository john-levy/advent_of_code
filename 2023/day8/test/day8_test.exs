defmodule Day8Test do
  use ExUnit.Case
  doctest Day8
  import Day8

  def get_input() do
    """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """
  end

  ##############
  # PART 1
  ##############

  test "parses a node to tuple of name and tuple of left/right mapping" do
    assert parse_node("AAA = (BBB, CCC)") == {"AAA", {"BBB", "CCC"}}
    assert parse_node("BBB = (DDD, EEE)") == {"BBB", {"DDD", "EEE"}}
    assert parse_node("CCC = (ZZZ, GGG)") == {"CCC", {"ZZZ", "GGG"}}
    assert parse_node("DDD = (DDD, DDD)") == {"DDD", {"DDD", "DDD"}}
    assert parse_node("EEE = (EEE, EEE)") == {"EEE", {"EEE", "EEE"}}
    assert parse_node("GGG = (GGG, GGG)") == {"GGG", {"GGG", "GGG"}}
    assert parse_node("ZZZ = (ZZZ, ZZZ)") == {"ZZZ", {"ZZZ", "ZZZ"}}
  end

  test "parses input to instructions and network" do
    {instructions, mapping} = parse_instructions_and_mapping(get_input())
    assert instructions == ["R", "L"]

    assert mapping == %{
             "AAA" => {"BBB", "CCC"},
             "BBB" => {"DDD", "EEE"},
             "CCC" => {"ZZZ", "GGG"},
             "DDD" => {"DDD", "DDD"},
             "EEE" => {"EEE", "EEE"},
             "GGG" => {"GGG", "GGG"},
             "ZZZ" => {"ZZZ", "ZZZ"}
           }
  end

  test "calculates part 1 example 1 steps correctly" do
    assert solution1(get_input()) == 2
  end

  test "calculates part 1 example 2 steps correctly" do
    input = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

    assert solution1(input) == 6
  end

  test "solution1" do
    assert solution1() == 14429
  end

  ##############
  # PART 2
  ##############

  def get_input2() do
    """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
  end

  test "extracts start points" do
    {_, map} = parse_instructions_and_mapping(get_input2())
    assert extract_start_points(map) == ["11A", "22A"]
  end

  test "calculates part 2 example steps correctly" do
    assert solution2(get_input2()) == 6
  end

  test "calculates the least common multiple of a list of numbers" do
  end

  test "calculates prime factors of a number" do
    assert calculate_prime_factors(100) == [5, 5, 2, 2]
    assert calculate_prime_factors(60) == [5, 3, 2, 2]
  end

  test "calculates part 2 example steps correctly via least common multiple" do
    assert solution2_lcm(get_input2()) == 6
  end

  test "solution2" do
    assert solution2_lcm() == 10_921_547_990_923
  end
end
