defmodule SudokuValidator do
  @moduledoc """
  This module is responsible for returning if a Sudoku grid is valid.
  """

  alias SudokuValidator.Grid

  @incomplete_number_marker 0

  @doc """
  Returns a string saying if a sudoku grid is:

  - Valid and complete
  - Valid and incomplete
  - Invalid
  """
  def validate(raw_grid) do
    parsed_grid = Grid.extract(raw_grid)

    cond do
      valid_grid?(parsed_grid) && incomplete_grid?(parsed_grid) ->
        "This sudoku grid is incomplete."

      valid_grid?(parsed_grid) ->
        "This sudoku grid is valid."

      true ->
        "This sudoku grid is invalid."
    end
  end

  defp validate_row(grid, row_number) do
    grid
    |> Grid.fetch_row(row_number)
    |> check_validity()
  end

  defp validate_column(grid, column_number) do
    grid
    |> Grid.fetch_column(column_number)
    |> check_validity()
  end

  defp validate_subgroup(grid, subgroup_number) do
    grid
    |> Grid.fetch_subgroup(subgroup_number)
    |> check_validity()
  end

  defp has_duplicate_numbers_in_list?(list) do
    list
    |> Enum.reject(fn number -> number == @incomplete_number_marker end)
    |> Enum.any?(fn number ->
      Enum.count(list, fn item -> item == number end) != 1
    end)
  end

  defp valid_grid?(grid) do
    rows = Enum.map(0..8, fn index -> validate_row(grid, index) end)
    columns = Enum.map(0..8, fn index -> validate_column(grid, index) end)
    subgroups = Enum.map(0..8, fn index -> validate_subgroup(grid, index) end)

    [rows, columns, subgroups]
    |> List.flatten()
    |> Enum.all?(fn item -> item == :valid end)
  end

  defp incomplete_grid?(grid) do
    rows = Enum.map(0..8, fn index -> Grid.fetch_row(grid, index) end)
    columns = Enum.map(0..8, fn index -> Grid.fetch_column(grid, index) end)
    subgroups = Enum.map(0..8, fn index -> Grid.fetch_subgroup(grid, index) end)

    [rows, columns, subgroups]
    |> List.flatten()
    |> Enum.member?(@incomplete_number_marker)
  end

  defp check_validity(list) do
    if has_duplicate_numbers_in_list?(list) do
      :invalid
    else
      :valid
    end
  end
end
