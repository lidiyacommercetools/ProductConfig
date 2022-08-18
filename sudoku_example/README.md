To run the sudoku examples, use the files in the "encoding" folder. https://github.com/lidiyacommercetools/ProductConfig/tree/main/encoding

However, replace the "general" and "path" files with the "sudoku_extension" file.

All examples will be based on the below Sudoku instance.


![Image 8-18-22 at 12 08 PM](https://user-images.githubusercontent.com/81679574/185370530-7f762384-9dae-4e62-9db1-10ebba8c94c4.jpg)


# Option One for Reasoning

Why is cell (X,Y) of the value N?

  Option 1: Why is value N not in another cell in the row, column, or block?
  
  Option 2: Why is the cell (X,Y) not another value?
  
![default](https://user-images.githubusercontent.com/81679574/181915457-f370664e-ed34-4cbe-be2a-c20f25aca692.png)

When the explanation ends with "why is the cell of that value", the process begins again anew. This method only works when the cell (X,Y) can be explained using only opiginal facts. An example of this can be found here. 

https://github.com/lidiyacommercetools/ProductConfig/blob/main/sudoku_example/example_9x9.md


Since most instances in sudoku require more than just the original facts, this approach is not optimal. For every "why", we have to ask eight "why not", causing the problem to explode. Also, there are circular references, since each cell in the grid depeneds on the other cells, causing circular explanations.


A single "why" question results in eight "why not". 

0 non-facts and 8 facts: 0 more "why not"
1 non-facts and 7 facts: 8 more "why not"
2 non-facts and 6 facts: 16 more "why not"
3 non-facts and 5 facts: 24 more "why not"
4 non-facts and 4 facts: 32 more "why not"
5 non-facts and 3 facts: 40 more "why not"
6 non-facts and 2 facts: 48 more "why not"
7 non-facts and 1 facts: 56 more "why not"
8 non-facts and 0 facts: 64 more "why not"

# Option Two for Reasoning

Another approach was to try using an unsat core. Given the original facts, the atom in question was incorporated into a constraint to create an unsat core. The goal is to explain why the unsat core serves as reasoning for why a certain cell is of a certain value.

## Example 1: Looking for an explanation for sudoku(8,1,6). 

One of the unsat cores is as follows:

initial(1,2,6)

initial(5,3,6)

initial(7,1,2)

initial(9,1,7)


Goal: Show how the unsat core explains sudoku(8,1,6).

![Image 8-18-22 at 8 30 PM](https://user-images.githubusercontent.com/81679574/185468310-647b26c6-d1c9-4268-9bc4-191a9f92cf86.jpg)

Cell (7,1) cannot be of value 6 because it is already of value 2. Similarly, cell (9,1) cannot be of value 6 because it is already of value 7. The cells in column 2 cannot be of value 6 because of initial(1,2,6) (a column cannot have the same value twice) and column 3 cannot contain another value 6 as cell (5,3) is already a 6.

(7,1) and (9,1) are explained by the constraint that each cell can not be of multiple values. And cells (7,2),(8,2),(9,2),(7,3),(8,3), and (9,3) are explained by the constraint that each row can contain each value between 1 and 9 only once.

![Image 8-18-22 at 8 38 PM](https://user-images.githubusercontent.com/81679574/185469612-235ad8bb-54af-485f-848d-d6c1fdbb56f4.jpg)


## Example 2: Looking for an explanation for sudoku(1,1,1). 

One of the unsat cores is as follows:

initial(1,2,6)

initial(1,8,3)

initial(2,1,8)

initial(4,2,3)

initial(5,3,6)

initial(6,2,1)

initial(7,1,2)

initial(9,1,7)


Goal: Show how the unsat core explains sudoku(1,1,1).

![Image 8-18-22 at 8 55 PM](https://user-images.githubusercontent.com/81679574/185473215-9d8ed163-3e2c-4111-aaca-a6ef42f7f16b.jpg)

Based on the three constraints in the original encoding, the unsat core does not explain sudoku(1,1,1).

However, with a combination of the constraints and some sudoku logic, it is possible to use the unsat core to explain sudoku(1,1,1). 

The problem is that using the meta programming method with ASP, the only way to use the logic and tricks of sudoku (outside of the basic rules of the game) is to code every possible strategy. This is not optimal. Therefore, a different method should be used for explanations in sudoky when the cell requires more than just the original facts and rules of the game to derive.




![Image 8-15-22 at 8 52 PM](https://user-images.githubusercontent.com/81679574/184697559-428a8b20-fff1-46df-bc8b-e49af304a5f5.jpg)


The image formalizes the above conclusion. If the unsat core in combination with rules and constraints of sudoku can explain the cell, then the meta programming with ASP can be used. If a strategy is needed to explain the cell, a different method should be used.




# Key Takeaway:

The approaches discussed above work in explanations of sudoku only when the cell in question can be described using initial facts and the three rules of the game (uniqueness in row, uniqueness in column, and uniqueness in the 3x3 block).
