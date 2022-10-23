To run the explain sudoku package: 

clingo sudoku_explain.lp reified_sudoku_encoding.lp why.lp sudoku_encoding.lp unsat_core.lp


Where:

reified_sudoku_encoding : The reified output of your particular sudoku instance. All original facts need to be included in the code as #external sudoku(A,B,C).
To reify the code, use: clingo --output=reify file.lp


why: Contains the cell you would like to explain. For example, why(sudoku(A,B,C)).


unsat_core: Unsat core to be used in the explanation.



