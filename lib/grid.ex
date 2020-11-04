defmodule SudokuValidator.Grid do
  @moduledoc """
  Functions to manipulate a sudoku grid in an easier way.
  """

  defdelegate extract(raw_grid), to: SudokuValidator.GridExtractor, as: :extract

  @doc """
  Fetches the row for a given sudoku grid structure.
  """
  def fetch_row(grid, row_number) do
    case row_number do
      row_number when row_number in 0..2 ->
        ["left", "center", "right"]
        |> Enum.map(fn pos -> Enum.at(grid["upper"][pos], row_number) end)
        |> Enum.reduce(fn cols, acc ->
          Enum.concat(acc, cols)
        end)
      row_number when row_number in 3..5 ->
        ["left", "center", "right"]
        |> Enum.map(fn pos -> Enum.at(grid["center"][pos], row_number - 3) end)
        |> Enum.reduce(fn cols, acc ->
          Enum.concat(acc, cols)
        end)
      row_number when row_number in 6..8 ->
        ["left", "center", "right"]
        |> Enum.map(fn pos -> Enum.at(grid["lower"][pos], row_number - 6) end)
        |> Enum.reduce(fn cols, acc ->
          Enum.concat(acc, cols)
        end)
    end
  end
end
