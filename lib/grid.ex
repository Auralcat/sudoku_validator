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
    |> concat_fetched_items()
  end

  def fetch_row(%{"center" => center_subgroups}, row_number) when row_number in 3..5 do
    ["left", "center", "right"]
    |> Enum.map(fn pos -> Enum.at(center_subgroups[pos], row_number - 3) end)
    |> concat_fetched_items()
  end

  def fetch_row(%{"lower" => lower_subgroups}, row_number) when row_number in 6..8 do
    ["left", "center", "right"]
    |> Enum.map(fn pos -> Enum.at(lower_subgroups[pos], row_number - 6) end)
    |> concat_fetched_items()
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
    |> concat_fetched_items()
  end

  def fetch_column(grid, col_number) when col_number in 3..5 do
    ["upper", "center", "lower"]
    |> Enum.map(fn section ->
      Enum.map(0..2, fn pos ->
        Enum.at(grid[section]["center"], pos) |> Enum.at(col_number - 3)
      end)
    end)
    |> concat_fetched_items()
  end

  def fetch_column(grid, col_number) when col_number in 6..8 do
    ["upper", "center", "lower"]
    |> Enum.map(fn section ->
      Enum.map(0..2, fn pos ->
        Enum.at(grid[section]["right"], pos) |> Enum.at(col_number - 6)
      end)
    end)
    |> concat_fetched_items()
  end

  def fetch_subgroup(grid, subgroup_number) do
    case subgroup_number do
      0 ->
        grid["upper"]["left"]
      1 ->
        grid["upper"]["center"]
      2 ->
        grid["upper"]["right"]
      3 ->
        grid["center"]["left"]
      4 ->
        grid["center"]["center"]
      5 ->
        grid["center"]["right"]
      6 ->
        grid["lower"]["left"]
      7 ->
        grid["lower"]["center"]
      8 ->
        grid["lower"]["right"]
    end
    |> concat_fetched_items()
  end

  defp concat_fetched_items(items) do
    Enum.reduce(items, [], fn single_item, acc ->
      Enum.concat(acc, single_item)
    end)
  end
end
