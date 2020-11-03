defmodule SudokuValidator.Grid do
  @moduledoc """
  Functions to manipulate a sudoku grid in an easier way.
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
      String.split(section, "\n", trim: true)
      |> Enum.map(fn x ->
        split_vertical_separators(x)
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
      "upper" => %{
        "left" => [
          Enum.at(Enum.at(nested_subgroups, 0), 0) |> Enum.at(0),
          Enum.at(Enum.at(nested_subgroups, 0), 1) |> Enum.at(0),
          Enum.at(Enum.at(nested_subgroups, 0), 2) |> Enum.at(0)
        ],
        "center" => [
          Enum.at(Enum.at(nested_subgroups, 0), 0) |> Enum.at(1),
          Enum.at(Enum.at(nested_subgroups, 0), 1) |> Enum.at(1),
          Enum.at(Enum.at(nested_subgroups, 0), 2) |> Enum.at(1)
        ],
        "right" => [
          Enum.at(Enum.at(nested_subgroups, 0), 0) |> Enum.at(2),
          Enum.at(Enum.at(nested_subgroups, 0), 1) |> Enum.at(2),
          Enum.at(Enum.at(nested_subgroups, 0), 2) |> Enum.at(2)
        ]
      },
      "center" => %{
        "left" => [
          Enum.at(Enum.at(nested_subgroups, 1), 0) |> Enum.at(0),
          Enum.at(Enum.at(nested_subgroups, 1), 1) |> Enum.at(0),
          Enum.at(Enum.at(nested_subgroups, 1), 2) |> Enum.at(0)
        ],
        "center" => [
          Enum.at(Enum.at(nested_subgroups, 1), 0) |> Enum.at(1),
          Enum.at(Enum.at(nested_subgroups, 1), 1) |> Enum.at(1),
          Enum.at(Enum.at(nested_subgroups, 1), 2) |> Enum.at(1)
        ],
        "right" => [
          Enum.at(Enum.at(nested_subgroups, 1), 0) |> Enum.at(2),
          Enum.at(Enum.at(nested_subgroups, 1), 1) |> Enum.at(2),
          Enum.at(Enum.at(nested_subgroups, 1), 2) |> Enum.at(2)
        ]
      },
      "lower" => %{
        "left" => [
          Enum.at(Enum.at(nested_subgroups, 2), 0) |> Enum.at(0),
          Enum.at(Enum.at(nested_subgroups, 2), 1) |> Enum.at(0),
          Enum.at(Enum.at(nested_subgroups, 2), 2) |> Enum.at(0)
        ],
        "center" => [
          Enum.at(Enum.at(nested_subgroups, 2), 0) |> Enum.at(1),
          Enum.at(Enum.at(nested_subgroups, 2), 1) |> Enum.at(1),
          Enum.at(Enum.at(nested_subgroups, 2), 2) |> Enum.at(1)
        ],
        "right" => [
          Enum.at(Enum.at(nested_subgroups, 2), 0) |> Enum.at(2),
          Enum.at(Enum.at(nested_subgroups, 2), 1) |> Enum.at(2),
          Enum.at(Enum.at(nested_subgroups, 2), 2) |> Enum.at(2)
        ]
      }
    }
  end
end
