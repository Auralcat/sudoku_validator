defmodule SudokuValidatorTest do
  use ExUnit.Case

  test "validates complete sudoku grids" do
    {:ok, complete_valid_grid} = File.read(File.cwd! <> "/test/fixtures/valid_complete.sudoku")
    result = SudokuValidator.validate(complete_valid_grid)

    assert result == "This sudoku grid is valid."
  end

  test "validates incomplete sudoku grids" do
    {:ok, incomplete_valid_grid} = File.read(File.cwd! <> "/test/fixtures/valid_incomplete.sudoku")
    result = SudokuValidator.validate(incomplete_valid_grid)

    assert result == "This sudoku grid is incomplete."
  end

  test "tells when a sudoku grid is invalid" do
    {:ok, invalid_due_to_row} = File.read(File.cwd! <> "/test/fixtures/invalid_due_to_row_dupe.sudoku")
    {:ok, invalid_due_to_column} = File.read(File.cwd! <> "/test/fixtures/invalid_due_to_column_dupe.sudoku")
    {:ok, invalid_due_to_subgroup} = File.read(File.cwd! <> "/test/fixtures/invalid_due_to_subgroup_dupe.sudoku")

    row_result = SudokuValidator.validate(invalid_due_to_row)
    column_result = SudokuValidator.validate(invalid_due_to_column)
    subgroup_result = SudokuValidator.validate(invalid_due_to_subgroup)

    assert row_result == "This sudoku grid is invalid."
    assert column_result == "This sudoku grid is invalid."
    assert subgroup_result == "This sudoku grid is invalid."
  end
end
