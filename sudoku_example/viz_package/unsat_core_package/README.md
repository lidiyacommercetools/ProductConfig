To calculate an unsat core:

clingo unsat_xplain.lp sudoku_encoding.lp your_unsat_input.lp


The output will be an unsat core. Note that it might not be the minimal unsat core. Save the desired results as "unsat_core" as the file will be used later.
