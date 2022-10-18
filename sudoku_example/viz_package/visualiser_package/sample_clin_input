why(1,2,6).

initial_unsat(2,9,6).

initial_unsat(3,5,6).

initial_unsat(1,3,2).

initial_unsat(1,1,7).


{sol(1);sol(2)}=1.


explain(sudoku(1,1,7),initial(1,1,7)):-sol(1).
explain(sudoku(1,3,2),initial(1,3,2)):-sol(1).
explain(sudoku(2,9,6),sudoku(1,9,6)):-sol(1).
explain(sudoku(2,9,6),sudoku(1,8,6)):-sol(1).
explain(sudoku(2,9,6),sudoku(1,7,6)):-sol(1).
explain(sudoku(3,5,6),sudoku(1,6,6)):-sol(1).
explain(sudoku(3,5,6),sudoku(1,5,6)):-sol(1).
explain(sudoku(3,5,6),sudoku(1,4,6)):-sol(1).



explain(sudoku(1,1,7),initial(1,1,7)):-sol(2).
explain(sudoku(1,3,2),initial(1,3,2)):-sol(2).
explain(sudoku(2,9,6),sudoku(2,3,6)):-sol(2).
explain(sudoku(2,9,6),sudoku(2,2,6)):-sol(2).
explain(sudoku(2,9,6),sudoku(2,1,6)):-sol(2).
explain(sudoku(3,5,6),sudoku(3,3,6)):-sol(2).
explain(sudoku(3,5,6),sudoku(3,2,6)):-sol(2).
explain(sudoku(3,5,6),sudoku(3,1,6)):-sol(2).
