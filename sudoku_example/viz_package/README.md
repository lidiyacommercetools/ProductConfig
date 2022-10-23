The goal of this "package" is to use visualize explanation in Sudoku. The explanations are based on unsat cores, and utilize only the original facts. The user has to provide the following files:

clin_instances : This file has to list all of the original facts of the sudoku instance. An example of the formatting can be found here https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/sample_clin_instances.lp

clin_input: This file has to contain information regarding which cell you would like to be explained. For example "why(1,2,6)" which is asking as to why the cell (1,2) is of value 6.

unsat_core: This can be calculated using any unsat core package. A sample one is provided ( https://github.com/lidiyacommercetools/ProductConfig/tree/main/sudoku_example/viz_package/unsat_core_package.lp ) but the code does not always find the minimal unsat core. If this is the desired unsat core, please seek a different source. To run the sample unsat core code, make sure to adjust "case_specific" for your exact insance and to maintain the formatting. The output should be saved in the format "initial_unsat(X,Y,N)." Where (X,Y) are the coordinates and N is the value. An example can be found here: https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/sample_unsat_core.lp


STEPS:

1. Calculate or provide unsat core

2. Calculate explanation using the unsat core

3. Run the visualizer 


To pipe results from step 1 to step 2.

clingo unsat_xplain.lp sudoku_encoding.lp easy_unsat_input.lp -V0 --out-atomf=%s. | head -n 1 | clingo - sudoku_explain.lp reified_sudoku_encoding.lp easy_why.lp sudoku_encoding.lp

clingo unsat_xplain.lp sudoku_encoding.lp easy_unsat_input.lp -V0 --out-atomf=%s. | head -n 1 | clingo - sudoku_explain.lp reified_sudoku_encoding.lp easy_why.lp sudoku_encoding.lp -V0 --out-atomf=%s. | head -n 1 | clingo - sudoku_encoding.lp easy_unsat_core.lp easy_why.lp sample_instances.lp -n 0 --outf=2 | clingraph --view --dir='out/sudoku' --format=png --out=render --prefix=viz_ --engine=neato --default-graph=sudoku --viz-encoding=clin_viz.lp --name-format=model_{model_number}
