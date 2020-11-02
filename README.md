# SudokuValidator

From the [challenge repo](https://github.com/thoughtbot-upcase-exercises/sudoku-validator):

> Sudoku is a logic-based combinatorial number-placement puzzle. The objective is to fill a 9×9 grid with digits so that each column, each row, and each of the nine 3×3 sub-grids that compose the grid contains all of the digits from 1 to 9.

> Write a command-line program that can read a file containing a Sudoku grid and validates it. The grid can be partially or completely solved. Return either a success message or a list of errors and their positions.

# How the grids are represented
We represent a Sudoku grid as follows:

```
8 5 0 |0 0 2 |4 0 0
7 2 0 |0 0 0 |0 0 9
0 0 4 |0 0 0 |0 0 0
------+------+------
0 0 0 |1 0 7 |0 0 2
3 0 5 |0 0 0 |9 0 0
0 4 0 |0 0 0 |0 0 0
------+------+------
0 0 0 |0 8 0 |0 7 0
0 1 7 |0 0 0 |0 0 0
0 0 0 |0 3 6 |0 4 0
```

Important: zeros represent squares which do not have a value assigned yet. Having multiple zeroes in a row, column, or subgroup does not make the puzzle invalid.
