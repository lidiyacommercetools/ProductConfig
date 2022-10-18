To run the visualiser: 

clingo sudoku_encoding  clin_input clin_instances -n 0 --outf=2 | clingraph --view --dir='out/sudoku' --format=png --out=render --prefix=viz_ --engine=neato --default-graph=sudoku --viz-encoding=clin_viz --name-format=model_{model_number}

clin_input : Unsat core, the why atom, and the explanation to be modeled. An example can be found here   https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/visualiser_package/sample_clin_input

sudoku_encoding : https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/unsat_core_package/sudoku_encoding

clin_instances: The instances for your particular sudoku. An example can be found here https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/viz_package/sample_clin_instances

