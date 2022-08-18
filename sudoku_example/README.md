To run the sudoku examples, use the files in the "encoding" folder. https://github.com/lidiyacommercetools/ProductConfig/tree/main/encoding

However, replace the "general" and "path" files with the "sudoku_extension" file.

All examples will be based on the below Sudoku instance.


![Image 8-18-22 at 12 08 PM](https://user-images.githubusercontent.com/81679574/185370530-7f762384-9dae-4e62-9db1-10ebba8c94c4.jpg)


## Option One for Reasoning

Why is cell (X,Y) of the value N?

  Option 1: Why is value N not in another cell in the row, column, or block?
  
  Option 2: Why is the cell (X,Y) not another value?
  
![default](https://user-images.githubusercontent.com/81679574/181915457-f370664e-ed34-4cbe-be2a-c20f25aca692.png)

When the explanation ends with "why is the cell of that value", the process begins again anew.

Anything that can be proven using only facts, can be treated as a fact itself.




## Option Two for Reasoning

Another approach was to try using an unsat core. Given the original facts, the atom in question was incorporated into a constraint to create an unsat core. The goal is to explain why the unsat core serves as reasoning for why a certain cell is of a certain value.

Example: Looking for an explanation for sudoku(8,1,6). One of the unsat cores is as follows:

initial(1,2,6)

initial(5,3,6)

initial(7,1,2)

initial(9,1,7)


Goal: Show how the unsat core explain sudoku(8,1,6).


![Image 8-15-22 at 8 52 PM](https://user-images.githubusercontent.com/81679574/184697559-428a8b20-fff1-46df-bc8b-e49af304a5f5.jpg)
