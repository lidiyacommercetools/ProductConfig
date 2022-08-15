To run the sudoku examples, use the files in the "encoding" folder. https://github.com/lidiyacommercetools/ProductConfig/tree/main/encoding

However, replace the "general" and "path" files with the "sudoku_extension" file.


## Option One for Reasoning

Why is cell (X,Y) of the value N?

  Option 1: Why is value N not in another cell in the row, column, or block?
  
  Option 2: Why is the cell (X,Y) not another value?
  
![default](https://user-images.githubusercontent.com/81679574/181915457-f370664e-ed34-4cbe-be2a-c20f25aca692.png)

When the explanation ends with "why is the cell of that value", the process begins again anew.

Anything that can be proven using only facts, can be treated as a fact itself.


## Option Two for Reasoning

Utilizing the unsat core.

![Image 8-15-22 at 8 52 PM](https://user-images.githubusercontent.com/81679574/184697559-428a8b20-fff1-46df-bc8b-e49af304a5f5.jpg)
