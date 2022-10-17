The goal of this "package" is to use visualize explanation in Sudoku. The explanations are based on unsat cores, and utilize only the original facts. The user has to provide the following files:

clin_instances : This file has to list all of the original facts of the sudoku instance. An example of the formatting can be found here https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/sample_clin_instances

clin_input: This file has to contain information regarding which cell you would like to be explained. For example "why(1,2,6)" which is asking as to why the cell (1,2) is of value 6.
