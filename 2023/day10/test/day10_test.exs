defmodule Day10Test do
  use ExUnit.Case
  doctest Day10
  import Day10

  def input1() do
    """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """
  end

  def input2() do
    """
    7-F7-
    .FJ|7
    SJLL7
    |F--J
    LJ.LJ
    """
  end

  def input3() do
    """
    ...........
    .S-------7.
    .|F-----7|.
    .||.....||.
    .||.....||.
    .|L-7.F-J|.
    .|..|.|..|.
    .L--J.L--J.
    ...........
    """
  end

  def input4() do
    """
    .F----7F7F7F7F-7....
    .|F--7||||||||FJ....
    .||.FJ||||||||L7....
    FJL7L7LJLJ||LJ.L-7..
    L--J.L7...LJS7F-7L7.
    ....F-J..F7FJ|L7L7L7
    ....L7.F7||L7|.L7L7|
    .....|FJLJ|FJ|F7|.LJ
    ....FJL-7.||.||||...
    ....L---J.LJ.LJLJ...
    """
  end

  def input5() do
    """
    FF7FSF7F7F7F7F7F---7
    L|LJ||||||||||||F--J
    FL-7LJLJ||||||LJL-77
    F--JF--7||LJLJ7F7FJ-
    L---JF-JLJ.||-FJLJJ7
    |F|F-JF---7F7-L7L|7|
    |FFJF7L7F-JF7|JL---7
    7-L-JL7||F7|L7F-7F7|
    L.L7LFJ|||||FJL7||LJ
    L7JLJL-JLJLJL--JLJ.L
    """
  end

  ##############
  # PART 1
  ##############

  test "parses sketch into map where key represents 2d array index and value is tile" do
    input = "123\n456\n789\n"

    assert parse_sketch(input) == %{
             {0, 0} => "1",
             {0, 1} => "2",
             {0, 2} => "3",
             {1, 0} => "4",
             {1, 1} => "5",
             {1, 2} => "6",
             {2, 0} => "7",
             {2, 1} => "8",
             {2, 2} => "9"
           }
  end

  test "finds start location" do
    assert parse_sketch(input1())
           |> find_start() == {1, 1}

    assert parse_sketch(input2())
           |> find_start() == {2, 0}
  end

  test "traces loop and returns example step count correctly" do
    assert trace_loop(parse_sketch(input1())) == 8
    assert trace_loop(parse_sketch(input2())) == 16
  end

  test "calculates furthest points for part 1 example data correctly" do
    assert solution1(input1()) == 4
    assert solution1(input2()) == 8
  end

  test "solution1" do
    assert solution1() == 6690
  end

  ##############
  # PART 2
  ##############

  test "defines a loop as a map of indices and tiles" do
    assert define_loop(parse_sketch(input1())) ==
             %{
               {1, 2} => "-",
               {1, 3} => "7",
               {2, 3} => "|",
               {3, 3} => "J",
               {3, 2} => "-",
               {3, 1} => "L",
               {2, 1} => "|",
               {1, 1} => "S"
             }
  end

  test "evaluates whether an index is contained within a loop" do
    sketch1 = parse_sketch(input1())
    sketch2 = parse_sketch(input2())
    assert !is_enclosed(define_loop(sketch1), {0, 0})
    assert !is_enclosed(define_loop(sketch2), {0, 0})
    assert is_enclosed(define_loop(sketch1), {2, 2})
    assert is_enclosed(define_loop(sketch2), {2, 2})
  end

  test "determines part 2 example area of loops correctly" do
    assert solution2(input1()) == 1
    assert solution2(input2()) == 1
    assert solution2(input3()) == 4
    assert solution2(input4()) == 8
    assert solution2(input5()) == 10
  end

  test "solution2" do
    assert solution2() == 525
  end
end
