defmodule Day5Test do
  use ExUnit.Case
  doctest Day5
  import Day5

  def test_input() do
    """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
    """
  end

  ##############
  # PART 3
  ##############

  test "maps input value to output" do
    assert map_input_to_output(49, [100, 50, 30]) == nil
    assert map_input_to_output(50, [100, 50, 30]) == 100
    assert map_input_to_output(65, [100, 50, 30]) == 115
    assert map_input_to_output(79, [100, 50, 30]) == 129
    assert map_input_to_output(80, [100, 50, 30]) == 130
    assert map_input_to_output(81, [100, 50, 30]) == nil
  end

  test "finds mapping if one exists" do
    assert find_mapping(49, [[100, 50, 30]]) == 49
    assert find_mapping(49, [[100, 50, 30], [10, 50, 5]]) == 49
    assert find_mapping(49, [[100, 50, 30], [10, 50, 5], [0, 40, 5]]) == 49
    assert find_mapping(49, [[100, 50, 30], [10, 40, 10], [0, 40, 5]]) == 19
  end

  test "finds part 1 example data location correctly" do
    [seeds | rest] =
      test_input()
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn e -> String.split(e, ":", trim: true) end)
      |> Enum.map(fn [_, map] -> map end)

    maps = parse_maps(rest)

    assert String.split(seeds, " ", trim: true)
           |> Enum.map(&String.to_integer/1)
           |> Enum.map(fn e -> map_location_number(e, maps) end)
           |> Enum.min() == 35
  end

  test "solution1" do
    assert solution1() == 457_535_844
  end

  ##############
  # PART 2
  ##############

  test "it can parse seed ranges into {start, length} tuples" do
    assert parse_seed_ranges("79 14 55 13") == [{55, 13}, {79, 14}]
  end

  test "finds part2 example data location correctly" do
    [seed_ranges | rest] =
      test_input()
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn e -> String.split(e, ":", trim: true) end)
      |> Enum.map(fn [_, map] -> map end)

    seeds = parse_seed_ranges(seed_ranges)
    maps = parse_maps(rest)

    assert Enum.map(seeds, fn {start, length} ->
             find_location_number_for_range(start, length, maps)
           end)
           |> Enum.min() == 46
  end

  test "solution2" do
    assert solution2() == 41_222_968
  end
end
