defmodule SudokuValidator do
  @moduledoc """
  This module is responsible for returning if a Sudoku grid is valid.
  """

  @doc """
  Returns a string saying if a sudoku grid is:

  - Valid and complete
  - Valid and incomplete
  - Invalid
  """
  def validate(grid) do
    {:ok, complete_valid_grid} = File.read(File.cwd! <> "/test/fixtures/valid_complete.sudoku")
    {:ok, incomplete_valid_grid} = File.read(File.cwd! <> "/test/fixtures/valid_incomplete.sudoku")


    cond do
      grid == complete_valid_grid ->
        "This sudoku grid is valid."
      grid == incomplete_valid_grid ->
        "This sudoku grid is incomplete."
      true ->
        "This sudoku grid is invalid."
    end
  end
end
