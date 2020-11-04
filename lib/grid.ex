defmodule SudokuValidator.Grid do
  @moduledoc """
  Functions to manipulate a sudoku grid in an easier way.
  """

  defdelegate extract(raw_grid), to: SudokuValidator.GridExtractor, as: :extract

  @doc """
  Fetches the row with the given order number for a given sudoku grid structure.
  """
  def fetch_row(%{"upper" => upper_subgroups}, row_number) when row_number in 0..2 do
    ["left", "center", "right"]
    |> Enum.map(fn pos -> Enum.at(upper_subgroups[pos], row_number) end)
    |> Enum.reduce(fn cols, acc ->
      Enum.concat(acc, cols)
    end)
  end

  def fetch_row(%{"center" => center_subgroups}, row_number) when row_number in 3..5 do
    ["left", "center", "right"]
    |> Enum.map(fn pos -> Enum.at(center_subgroups[pos], row_number - 3) end)
    |> Enum.reduce(fn cols, acc ->
      Enum.concat(acc, cols)
    end)
  end

  def fetch_row(%{"lower" => lower_subgroups}, row_number) when row_number in 6..8 do
    ["left", "center", "right"]
    |> Enum.map(fn pos -> Enum.at(lower_subgroups[pos], row_number - 6) end)
    |> Enum.reduce(fn cols, acc ->
      Enum.concat(acc, cols)
    end)
  end

  @doc """
  Fetches the column for a given sudoku grid and the input column number.
  """
  def fetch_column(grid, col_number) when col_number in 0..2 do
    ["upper", "center", "lower"]
    |> Enum.map(fn section ->
      Enum.map(0..2, fn pos ->
        Enum.at(grid[section]["left"], pos) |> Enum.at(col_number)
      end)
    end)
    |> Enum.reduce(fn cols, acc ->
      Enum.concat(acc, cols)
    end)
  end

  def fetch_column(grid, col_number) when col_number in 3..5 do
    ["upper", "center", "lower"]
    |> Enum.map(fn section ->
      Enum.map(0..2, fn pos ->
        Enum.at(grid[section]["center"], pos) |> Enum.at(col_number - 3)
      end)
    end)
    |> Enum.reduce(fn cols, acc ->
      Enum.concat(acc, cols)
    end)
  end

  def fetch_column(grid, col_number) when col_number in 6..8 do
    ["upper", "center", "lower"]
    |> Enum.map(fn section ->
      Enum.map(0..2, fn pos ->
        Enum.at(grid[section]["right"], pos) |> Enum.at(col_number - 6)
      end)
    end)
    |> Enum.reduce(fn cols, acc ->
      Enum.concat(acc, cols)
    end)
  end
end
