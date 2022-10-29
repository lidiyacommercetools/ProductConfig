The goal of this "package" is to use visualize explanation in Sudoku. The explanations are based on unsat cores, and utilize only the original facts. The user has to provide the following files:

clin_instances.lp : This file has to list all of the original facts of the sudoku instance. An example of the formatting can be found here https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/sample_clin_instances.lp

clin_input.lp : This file has to contain information regarding which cell you would like to be explained. For example "why(1,9,1)" which is asking as to why the cell (1,9) is of value 1. As well as the instances from clin_instances but in the format of {instance}. An example in formatting can be found here: https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/sample_unsat_input.lp

reified_sudoku_encoding.lp : This is the reified version of the sudoku encoding as well as the case specific instances. An example can be found here: https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/reified_sudoku_encoding.lp


STEPS:

1. Calculate or provide unsat core

2. Calculate explanation using the unsat core

3. Run the visualizer 



Example: why(1,9,1)

clingo sudoku_encoding.lp unsat_explain.lp sample_unsat_input.lp -V0 | clingo sudoku_explain.lp reified_sudoku_encoding.lp sample_why.lp sudoku_encoding.lp sample_clin_instances.lp unsat_core.lp -V0 --out-atomf=%s. | head -n 1 > explanation_input.lp | clingo - sudoku_encoding.lp sample_clin_instances.lp unsat_core.lp sample_why.lp explanation_input.lp -n 0 --outf=2 | clingraph --view --dir='out/sudoku' --format=png --out=render --prefix=viz_ --engine=neato --default-graph=sudoku --viz-encoding=clin_viz.lp


![0](https://user-images.githubusercontent.com/81679574/198844334-ef25232b-ed51-4c6d-9ceb-43188202ff30.png)


![1](https://user-images.githubusercontent.com/81679574/198844341-b5c7d864-3eae-4f8c-8136-f5048e1a02d5.png)


![2](https://user-images.githubusercontent.com/81679574/198844347-462a2caa-8afc-4744-b35f-bb41a7457dbb.png)


