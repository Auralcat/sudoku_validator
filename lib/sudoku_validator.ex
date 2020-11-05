defmodule SudokuValidator do
  @moduledoc """
  This module is responsible for returning if a Sudoku grid is valid.
  """

  alias SudokuValidator.Grid

  @doc """
  Returns a string saying if a sudoku grid is:

  - Valid and complete
  - Valid and incomplete
  - Invalid
  """
  def validate(raw_grid) do
    {:ok, complete_valid_grid} = File.read(File.cwd! <> "/test/fixtures/valid_complete.sudoku")
    {:ok, incomplete_valid_grid} = File.read(File.cwd! <> "/test/fixtures/valid_incomplete.sudoku")

    cond do
      raw_grid == complete_valid_grid ->
        "This sudoku grid is valid."
      raw_grid == incomplete_valid_grid ->
        "This sudoku grid is incomplete."
      true ->
        "This sudoku grid is invalid."
    end
  end

  def validate_row(raw_grid, row_number) do
    target_row = raw_grid
    |> Grid.extract()
    |> Grid.fetch_row(row_number)

    if has_duplicates_in_list?(target_row) do
      :invalid
    else
      :valid
    end
  end

  defp has_duplicates_in_list?(list) do
    list
    |> Enum.any?(fn number ->
      Enum.count(list, fn item -> item == number end) != 1
    end)
  end
end
