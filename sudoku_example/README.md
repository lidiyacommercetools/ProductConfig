To run the sudoku examples, use the files in the "encoding" folder. https://github.com/lidiyacommercetools/ProductConfig/tree/main/encoding

However, replace the "general" and "path" files with the "sudoku_extension" file.

All examples will be based on the below Sudoku instance.


![Image 8-18-22 at 12 08 PM](https://user-images.githubusercontent.com/81679574/185370530-7f762384-9dae-4e62-9db1-10ebba8c94c4.jpg)



![Image 8-20-22 at 11 00 AM](https://user-images.githubusercontent.com/81679574/185737651-151a05fb-5bea-4694-b855-d854f4bfcaa5.jpg)




# Option One for Reasoning

Why is cell (X,Y) of the value N?

  Option 1: Why is value N not in another cell in the row, column, or block?
  
  Option 2: Why is the cell (X,Y) not another value?
  


![Image 9-12-22 at 4 56 PM](https://user-images.githubusercontent.com/81679574/189687019-8823656b-6064-40f0-a174-6e53171d5209.jpg)


When the explanation ends with "why is the cell of that value", the process begins again anew. This method only works when the cell (X,Y) can be explained using only original facts, and none of the derived entries. An example of a "successful" explanation using Option One can be found here. 

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


## Pseudocode for reasoning option one


![Image 9-12-22 at 4 44 PM](https://user-images.githubusercontent.com/81679574/189684296-1a50b3b4-5654-4629-85b7-bd7005909300.jpg)

## Example 1: Looking for an explanation for sudoku(1,1,1). 

![default](https://user-images.githubusercontent.com/81679574/185745697-14a4efa6-1426-451c-9faf-c21df2378082.png)

The image shows that when the cell cannot be explained using only original facts, the problem explodes. The explanation for sudoku(1,1,1) uses two non-fact values, and the problem becomes 16 "why_not" questions. 

# Option Two for Reasoning

Another approach was to try using an unsat core. Given the original facts, the atom in question was incorporated into a constraint to create an unsat core. The goal is to explain why the unsat core serves as reasoning for why a certain cell is of a certain value.



![Image 9-12-22 at 8 22 PM](https://user-images.githubusercontent.com/81679574/189728066-116a51ee-94d3-423d-aa89-0ec59667b263.jpg)

## Example 2: Looking for an explanation for sudoku(8,1,6). 

% clingo why general unsatcore ins1_sudoku ins1_reified option_three


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


## Example 3: Looking for an explanation for sudoku(3,1,3). 

One of the unsat cores is as follows:

initial(1,8,3)

initial(2,1,8)

initial(4,2,3)

initial(7,3,3)


Goal: Show how the unsat core explains sudoku(3,1,3).




![Image 8-20-22 at 10 45 AM](https://user-images.githubusercontent.com/81679574/185736845-5a8781e5-f3fb-4464-9170-500ce8b9e31f.jpg)


![Image 8-20-22 at 10 48 AM](https://user-images.githubusercontent.com/81679574/185736973-cbe6718c-e06a-4bc9-94e3-9729bed4be5f.jpg)


## Example 4: Looking for an explanation for sudoku(1,1,1). 

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



# Option Three for Reasoning


The third approach is to combine the previous two. The problem with approach one is that there are too many options to choose from when explaining a cell. However, if only the unsat core was to be used in the explanation, it would significantly reduce the computation. 

Step 1 is to look at any "intermediate" derivations. Using the unsat core, can we explain any other cells within the Sudoku grid? If yes, perhaps this derived cell will be used to explain the cell we initially asked about.



![Image 9-12-22 at 7 20 PM](https://user-images.githubusercontent.com/81679574/189716967-9c842aa4-292a-4ecd-9241-c8339aa055e7.jpg)

In the diagram, an intermediate derivation N is based on the unsat core and the previous (N-1) intermediate derivations. Intermediate derivation 1 is based solely on the unsat core.


Step 2 is to use the derived cells as well as the unsat core to answer the initial "why" question.


![Image 9-13-22 at 3 16 PM](https://user-images.githubusercontent.com/81679574/189911062-277fb53f-ca5c-4e60-83a7-433c562390af.jpg)



## Example 5: Looking for an explanation for sudoku(1,1,1). 


One of the unsat cores is as follows:

initial(1,2,6)

initial(1,8,3)

initial(2,1,8)

initial(4,2,3)

initial(5,3,6)

initial(6,2,1)

initial(7,1,2)

initial(9,1,7)


### Step 1: Intermediate derivations of sudoku(8,1,6)


explain_der(sudoku(2,1,6),initial(2,1,8),1) 

explain_der(sudoku(7,1,6),initial(7,1,2),1) 

explain_der(sudoku(9,1,6),initial(9,1,7),1) 

explain_der(sudoku(1,1,6),sudoku(1,2,6),1) 

explain_der(sudoku(3,1,6),sudoku(1,2,6),1) 

explain_der(sudoku(5,1,6),sudoku(5,3,6),1) 

explain_der(sudoku(4,1,6),sudoku(5,3,6),1) 

explain_der(sudoku(6,1,6),sudoku(5,3,6),1)


![Image 8-30-22 at 6 17 PM](https://user-images.githubusercontent.com/81679574/187493347-8e21f9fd-628d-4e53-abaf-6192958eb872.jpg)


### Step 1: Intermediate derivations of sudoku(3,1,3)


explain_der(sudoku(2,1,3),initial(2,1,8),2) 

explain_der(sudoku(7,1,3),initial(7,1,2),2) 

explain_der(sudoku(9,1,3),initial(9,1,7),2)   

explain_der(sudoku(1,1,3),sudoku(1,8,3),2) 

explain_der(sudoku(4,1,3),sudoku(4,2,3),2) 

explain_der(sudoku(5,1,3),sudoku(4,2,3),2) 

explain_der(sudoku(6,1,3),sudoku(4,2,3),2) 


![Image 8-30-22 at 6 23 PM](https://user-images.githubusercontent.com/81679574/187493450-807e3de9-2134-4ed1-9cdc-fa3371157b00.jpg)


### Step 2: Explanation of sudoku(1,1,1)


explain(sudoku(8,1,6),derived) 

explain(sudoku(4,1,1),sudoku(6,2,1)) 

explain(sudoku(5,1,1),sudoku(6,2,1)) 

explain(sudoku(6,1,1),sudoku(6,2,1)) 

explain(sudoku(2,1,1),initial(2,1,8)) 

explain(sudoku(7,1,1),initial(7,1,2)) 

explain(sudoku(9,1,1),initial(9,1,7)) 

explain(sudoku(3,1,3),derived)

![Image 8-30-22 at 6 32 PM](https://user-images.githubusercontent.com/81679574/187493587-a15e8b0f-e366-40b6-a104-144d417101dd.jpg)


# Option Four for Reasoning

The problem of Proofdoku uses a different initial Sudoku encoding that is of interest. Instead of generating every possible option and then removing most based on constraints, the proofdoku encoding specifies limits on the initial choice rule. 

![Image 9-12-22 at 4 25 PM](https://user-images.githubusercontent.com/81679574/189679592-7ab6ceec-2b1b-46fa-9248-6387450f3f9b.jpg)

The goal was to utilise this encoding in partnership with the original Choice Rule encoding available at https://github.com/lidiyacommercetools/ProductConfig/blob/main/encoding/choice_rule

However, if atoms are introduced that are facts, the choice rules are still able to produce other fill/3 without producing an unsat set. Therefore, the original Choice Rule encoding would not be of use, without a special extension aimed specifically at this use case.

The Proofdoku paper ( https://adamsmith.as/papers/answer-set-programming-in-proofdoku.pdf ) states that "and if a cell has a clue, the number filled in that cell must match the clue." but that is not included in the code snippit. 

## Example 6: 

fill(1,1,1). %Provided as a fact

fill(1,1,2). %From a choice rule

Based on the rules of sudoku that we know, this cannot happen. However, nothing in the encoding states that it cannot.



