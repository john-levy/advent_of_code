defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  def load_file(path) do
    String.trim(File.read!(path))
  end

  ##############
  # PART 1
  ##############

  def parse_game(input) do
    [game, detail] = String.split(input, ":")
    handfuls = String.split(String.trim(detail), "; ") |> Enum.map(&parse_handful/1)

    max =
      Enum.reduce(handfuls, %{red: 0, green: 0, blue: 0}, fn e, acc ->
        {red, green, blue} = e
        max_red = max(red, acc.red)
        max_green = max(green, acc.green)
        max_blue = max(blue, acc.blue)
        %{red: max_red, green: max_green, blue: max_blue}
      end)

    {parse_game_id(game), max}
  end

  def parse_game_id(game) do
    String.to_integer(String.replace(game, "Game ", ""))
  end

  def parse_handful(input) do
    colors = String.split(input, ", ")
    {parse_color(colors, "red"), parse_color(colors, "green"), parse_color(colors, "blue")}
  end

  def parse_color(input, color) do
    result = Enum.find(input, fn e -> String.contains?(e, color) end)

    case result do
      nil -> 0
      _ -> String.to_integer(String.replace(result, " #{color}", ""))
    end
  end

  def possible({_, max}) do
    max.red <= 12 && max.green <= 13 && max.blue <= 14
  end

  def solution1 do
    load_file("data/input.txt")
    |> String.split("\n")
    |> Enum.map(&parse_game/1)
    |> Enum.filter(&possible/1)
    |> Enum.map(fn {id, _} -> id end)
    |> Enum.sum()
  end

  ##############
  # PART 2
  ##############

  def power({_, max}) do
    max.red * max.green * max.blue
  end

  def solution2 do
    load_file("data/input.txt")
    |> String.split("\n")
    |> Enum.map(&parse_game/1)
    |> Enum.map(&power/1)
    |> Enum.sum()
  end
end
