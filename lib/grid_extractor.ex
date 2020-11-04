defmodule SudokuValidator.GridExtractor do
  @moduledoc """
  Holds the code to extract a sudoku grid from a plain text file
  into a data structure for the app.
  """

  @doc """
  Turns a raw representation of a sudoku grid into an organized struct.
  Note that it does not validate the grid.
  """
  def extract(raw_grid) do
    separator = "------+------+------"

    raw_grid
    |> String.split(separator)
    |> into_number_strings()
    |> to_grid_map()
  end

  defp into_number_strings(raw_sections) do
    Enum.map(raw_sections, fn section ->
      section
      |> String.split("\n", trim: true)
      |> Enum.map(fn string_with_vertical_separator ->
        string_with_vertical_separator
        |> split_vertical_separators()
        |> split_numbers()
      end)
    end)
  end

  defp split_vertical_separators(raw_string) do
    String.split(raw_string, "|")
  end

  defp split_numbers(number_strings) do
    Enum.map(number_strings, fn numbers_with_spaces ->
      numbers_with_spaces
      |> String.split()
      |> Enum.map(fn number_string -> String.to_integer(number_string) end)
    end)
  end

  defp to_grid_map(nested_subgroups) do
    %{
      "upper" => subgroup_map(nested_subgroups, 0),
      "center" => subgroup_map(nested_subgroups, 1),
      "lower" => subgroup_map(nested_subgroups, 2)
    }
  end

  defp subgroup_map(nested_subgroups, index) do
    %{
      "left" => [
      Enum.at(Enum.at(nested_subgroups, index), 0) |> Enum.at(0),
      Enum.at(Enum.at(nested_subgroups, index), 1) |> Enum.at(0),
      Enum.at(Enum.at(nested_subgroups, index), 2) |> Enum.at(0)
    ],
      "center" => [
        Enum.at(Enum.at(nested_subgroups, index), 0) |> Enum.at(1),
        Enum.at(Enum.at(nested_subgroups, index), 1) |> Enum.at(1),
        Enum.at(Enum.at(nested_subgroups, index), 2) |> Enum.at(1)
      ],
      "right" => [
        Enum.at(Enum.at(nested_subgroups, index), 0) |> Enum.at(2),
        Enum.at(Enum.at(nested_subgroups, index), 1) |> Enum.at(2),
        Enum.at(Enum.at(nested_subgroups, index), 2) |> Enum.at(2)
      ]
    }
  end
end
