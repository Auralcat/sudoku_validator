defmodule SudokuValidatorTest do
  use ExUnit.Case
  doctest SudokuValidator

  test "greets the world" do
    assert SudokuValidator.hello() == :world
  end
end
