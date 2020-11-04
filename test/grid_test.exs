defmodule SudokuValidator.GridTest do
  use ExUnit.Case, async: true

  alias SudokuValidator.Grid

  test "fetch_row/2 returns the given row for a sudoku grid struct" do
    assert Grid.fetch_row(sample_complete_grid(), 0) == [8, 5, 9, 6, 1, 2, 4, 3, 7]
    assert Grid.fetch_row(sample_complete_grid(), 1) == [7, 2, 3, 8, 5, 4, 1, 6, 9]
    assert Grid.fetch_row(sample_complete_grid(), 2) == [1, 6, 4, 3, 7, 9, 5, 2, 8]
    assert Grid.fetch_row(sample_complete_grid(), 3) == [9, 8, 6, 1, 4, 7, 3, 5 ,2]
    assert Grid.fetch_row(sample_complete_grid(), 4) == [3, 7, 5, 2, 6, 8, 9, 1, 4]
    assert Grid.fetch_row(sample_complete_grid(), 5) == [2, 4, 1, 5, 9, 3, 7, 8 ,6]
    assert Grid.fetch_row(sample_complete_grid(), 6) == [4, 3, 2, 9, 8, 1, 6, 7, 5]
    assert Grid.fetch_row(sample_complete_grid(), 7) == [6, 1, 7, 4, 2, 5, 8, 9 ,3]
    assert Grid.fetch_row(sample_complete_grid(), 8) == [5, 9, 8, 7, 3, 6, 2, 4, 1]
  end

  test "fetch_column/2 returns the given column for a sudoku grid struct" do
    assert Grid.fetch_column(sample_complete_grid(), 0) == [8, 7, 1, 9, 3, 2, 4, 6, 5]
    assert Grid.fetch_column(sample_complete_grid(), 1) == [5, 2, 6, 8, 7, 4, 3, 1, 9]
    assert Grid.fetch_column(sample_complete_grid(), 2) == [9, 3, 4, 6, 5, 1, 2, 7, 8]
    assert Grid.fetch_column(sample_complete_grid(), 3) == [6, 8, 3, 1, 2, 5, 9, 4, 7]
    assert Grid.fetch_column(sample_complete_grid(), 4) == [1, 5, 7, 4, 6, 9, 8, 2, 3]
    assert Grid.fetch_column(sample_complete_grid(), 5) == [2, 4, 9, 7, 8, 3, 1, 5, 6]
    assert Grid.fetch_column(sample_complete_grid(), 6) == [4, 1, 5, 3, 9, 7, 6, 8, 2]
    assert Grid.fetch_column(sample_complete_grid(), 7) == [3, 6, 2, 5, 1, 8, 7, 9, 4]
    assert Grid.fetch_column(sample_complete_grid(), 8) == [7, 9, 8, 2, 4, 6, 5, 3, 1]
  end

  defp sample_complete_grid do
    %{
      "upper" => %{
        "left" => [[8, 5, 9], [7, 2, 3], [1, 6, 4]],
        "center" => [[6, 1, 2], [8, 5, 4], [3, 7, 9]],
        "right" => [[4, 3, 7], [1, 6, 9], [5, 2, 8]]
      },
      "center" => %{
        "left" => [[9, 8, 6], [3, 7, 5], [2, 4, 1]],
        "center" => [[1, 4, 7], [2, 6, 8], [5, 9, 3]],
        "right" => [[3, 5, 2], [9, 1, 4], [7, 8, 6]]
      },
      "lower" => %{
        "left" => [[4, 3, 2], [6, 1, 7], [5, 9, 8]],
        "center" => [[9, 8, 1], [4, 2, 5], [7, 3, 6]],
        "right" => [[6, 7, 5], [8, 9, 3], [2, 4, 1]]
      }
    }
  end
end
