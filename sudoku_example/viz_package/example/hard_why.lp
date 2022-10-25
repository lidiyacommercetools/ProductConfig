why(sudoku(1,9,1)).
why(A,B,C):- why(sudoku(A,B,C)).

time(0..2).