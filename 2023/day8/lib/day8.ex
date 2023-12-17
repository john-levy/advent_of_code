defmodule Day8 do
  @moduledoc """
  Documentation for `Day8`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def parse_instructions_and_mapping(file) do
    [instructions, networks | _] = String.split(file, "\n\n")
    map = Map.new(String.split(networks, "\n", trim: true), &parse_node/1)
    {String.graphemes(instructions), map}
  end

  def parse_node(node) do
    [name, mapping | _] = String.split(node, "=", trim: true)

    [left, right | _] =
      mapping
      |> String.replace(["(", ")"], "")
      |> String.split(",", trim: true)
      |> Enum.map(&String.trim/1)

    {String.trim(name), {left, right}}
  end

  def follow_instructions(node, [_instruction | _remaining], _map, _all_instructions, acc)
      when node == "ZZZ" do
    acc
  end

  def follow_instructions(node, [instruction | remaining], map, all_instructions, acc) do
    next = next_node(node, instruction, map)
    follow_instructions(next, remaining, map, all_instructions, acc + 1)
  end

  def follow_instructions(node, [], map, all_instructions, acc) do
    follow_instructions(node, all_instructions, map, all_instructions, acc)
  end

  def next_node(node, instruction, map) do
    {left, right} = Map.fetch!(map, node)

    case instruction do
      "L" -> left
      "R" -> right
    end
  end

  def solution1() do
    solution1(load_file("data/input.txt"))
  end

  def solution1(input) do
    {instructions, map} = parse_instructions_and_mapping(input)
    follow_instructions("AAA", instructions, map, instructions, 0)
  end

  ##############
  # PART 2
  ##############

  def follow_ghost_instructions(nodes, [], map, all_instructions, acc) do
    follow_ghost_instructions(nodes, all_instructions, map, all_instructions, acc)
  end

  def follow_ghost_instructions(nodes, [instruction | remaining], map, all_instructions, acc) do
    next = Enum.map(nodes, &next_node(&1, instruction, map))

    if at_end(next) do
      acc + 1
    else
      follow_ghost_instructions(next, remaining, map, all_instructions, acc + 1)
    end
  end

  def at_end(nodes) do
    Enum.all?(nodes, &(String.last(&1) == "Z"))
  end

  def extract_start_points(map) do
    Map.keys(map) |> Enum.filter(&(String.last(&1) == "A"))
  end

  def loop_count(node, [], map, all_instructions, acc) do
    loop_count(node, all_instructions, map, all_instructions, acc)
  end

  def loop_count(node, [instruction | remaining], map, all_instructions, acc) do
    next = next_node(node, instruction, map)

    if String.last(next) == "Z" do
      acc + 1
    else
      loop_count(next, remaining, map, all_instructions, acc + 1)
    end
  end

  def calculate_least_common_multiple(list) do
    Enum.map(list, &calculate_prime_factors/1)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.product()
  end

  def calculate_prime_factors(number) do
    calculate_prime_factors(number, 2, [])
  end

  def calculate_prime_factors(number, _, acc) when number == 1 do
    acc
  end

  def calculate_prime_factors(number, divisor, acc) do
    mod = rem(number, divisor)

    if mod == 0 do
      calculate_prime_factors(div(number, divisor), divisor, [divisor | acc])
    else
      calculate_prime_factors(number, divisor + 1, acc)
    end
  end

  def solution2() do
    solution2(load_file("data/input.txt"))
  end

  # simple solution is too expensive, apparently the inputs all loop after reaching a node that ends 
  # with 'Z', so find least common multiple of loop instead
  def solution2(input) do
    {instructions, map} = parse_instructions_and_mapping(input)
    start_points = extract_start_points(map)
    follow_ghost_instructions(start_points, instructions, map, instructions, 0)
  end

  def solution2_lcm() do
    solution2_lcm(load_file("data/input.txt"))
  end

  def solution2_lcm(input) do
    {instructions, map} = parse_instructions_and_mapping(input)
    start_points = extract_start_points(map)

    calculate_least_common_multiple(
      Enum.map(start_points, &loop_count(&1, instructions, map, instructions, 0))
    )
  end
end
