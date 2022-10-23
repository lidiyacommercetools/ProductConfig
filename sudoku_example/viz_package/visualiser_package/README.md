To run the visualiser: 

clingo sudoku_encoding.lp  clin_input.lp clin_instances.lp -n 0 --outf=2 | clingraph --view --dir='out/sudoku' --format=png --out=render --prefix=viz_ --engine=neato --default-graph=sudoku --viz-encoding=clin_viz.lp --name-format=model_{model_number}

clin_input.lp : Unsat core, the why atom, and the explanation to be modeled. An example can be found here   https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/visualiser_package/sample_clin_input.lp

sudoku_encoding.lp : https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/unsat_core_package/sudoku_encoding.lp

clin_instances.lp : The instances for your particular sudoku. An example can be found here https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/sample_clin_instances.lp



Running 

clingo sudoku_encoding.lp  sample_clin_input.lp clin_instances.lp -n 0 --outf=2 | clingraph --view --dir='out/sudoku' --format=png --out=render --prefix=viz_ --engine=neato --default-graph=sudoku --viz-encoding=clin_viz.lp --name-format=model_{model_number}

would result in the following two images.

![model_0](https://user-images.githubusercontent.com/81679574/196516914-21095c68-4339-4352-9d00-17ebdec334a9.png)
![model_1](https://user-images.githubusercontent.com/81679574/196516922-b4b2fc40-3aec-479a-875e-4252f1e4a93c.png)
