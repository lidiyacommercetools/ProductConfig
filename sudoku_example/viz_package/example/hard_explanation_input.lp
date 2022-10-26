
explain(sudoku(1,1,1),initial(1,1,7)). 
explain(sudoku(1,3,1),initial(1,3,2)). 
explain(sudoku(1,8,1),initial(1,8,8)). 
explain(sudoku(1,7,1),derived(1,7,3)). 
explain(sudoku(1,2,1),derived(1,2,6)). 
explain(sudoku(1,4,1),sudoku(2,4,1)). 
explain(sudoku(1,5,1),sudoku(2,4,1)). 
explain(sudoku(1,6,1),sudoku(2,4,1)). 


explain_der(sudoku(1,8,6),initial(1,8,8),1). 
explain_der(sudoku(1,3,6),initial(1,3,2),1). 
explain_der(sudoku(1,1,6),initial(1,1,7),1). 
explain_der(sudoku(1,7,6),sudoku(2,9,6),1). 
explain_der(sudoku(1,9,6),sudoku(2,9,6),1). 
explain_der(sudoku(1,4,6),sudoku(3,5,6),1). 
explain_der(sudoku(1,6,6),sudoku(3,5,6),1).
explain_der(sudoku(1,5,6),sudoku(3,5,6),1).
explain_der(sudoku(1,1,3),initial(1,1,7),2). 
explain_der(sudoku(1,3,3),initial(1,3,2),2). 
explain_der(sudoku(1,8,3),initial(1,8,8),2). 
explain_der(sudoku(1,4,3),sudoku(2,6,3),2). 
explain_der(sudoku(1,5,3),sudoku(2,6,3),2). 
explain_der(sudoku(1,6,3),sudoku(2,6,3),2).   
explain_der(sudoku(1,9,3),sudoku(8,9,3),2).


{chosen(0); chosen(1); chosen(2)}=1.

derived(1,7,3,2).
derived(1,2,6,1).