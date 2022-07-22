## Example 1:

why_not(sudoku(1,2,3)).

Answer 1: path(sudoku(1,2,3),sudoku(1,1,3),44,constraint,0) path(sudoku(1,1,3),sudoku(1,1,3),fact,fact,1)

Answer 2: path(sudoku(1,2,3),sudoku(4,2,3),44,constraint,0) path(sudoku(4,2,3),sudoku(4,2,3),7,choice_three,1)

According to answer 1, cell (1,2) cannot be the value 3 because row 1 already has a value 3 at cell (1,1). And the fact that cell (1,1) contains the value 3 is a fact.

According to answer 2, cell (1,2) cannot be the value 3 because column 2 already has a value 3 at cell (4,2). And the fact that cell (4,2) contains the value 3 is a fact.
