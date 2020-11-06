defmodule SudokuValidator.GridExtractorTest do
  use ExUnit.Case, async: true

  alias SudokuValidator.GridExtractor

  test "extracts the sudoku grid into the desired structure" do
    {:ok, raw_grid} = File.read(File.cwd!() <> "/test/fixtures/valid_complete.sudoku")

    result = GridExtractor.extract(raw_grid)

    assert result["upper"]["left"] == [[8, 5, 9], [7, 2, 3], [1, 6, 4]]
    assert result["upper"]["center"] == [[6, 1, 2], [8, 5, 4], [3, 7, 9]]
    assert result["upper"]["right"] == [[4, 3, 7], [1, 6, 9], [5, 2, 8]]
    assert result["center"]["left"] == [[9, 8, 6], [3, 7, 5], [2, 4, 1]]
    assert result["center"]["center"] == [[1, 4, 7], [2, 6, 8], [5, 9, 3]]
    assert result["center"]["right"] == [[3, 5, 2], [9, 1, 4], [7, 8, 6]]
    assert result["lower"]["left"] == [[4, 3, 2], [6, 1, 7], [5, 9, 8]]
    assert result["lower"]["center"] == [[9, 8, 1], [4, 2, 5], [7, 3, 6]]
    assert result["lower"]["right"] == [[6, 7, 5], [8, 9, 3], [2, 4, 1]]
  end
end
