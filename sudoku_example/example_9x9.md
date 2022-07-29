![proofdoku2](https://user-images.githubusercontent.com/81679574/180606563-7d55f9e6-2a3e-4407-ad2f-6d6446bab621.png)


![default](https://user-images.githubusercontent.com/81679574/181779039-85251830-4be3-4e8a-8c4f-ba08f64efe75.png)

Why is the cell (8,7) the value 5? Because there is no other position in the row where the value 5 could be.

Cells (8,8), (8,1), (8,5), and (8,2) are occupied by facts. Cell (8,9) cannot be value 5 because of a constraint issue with cell (6,9), which is a fact. Cells (8,6) and (8,4) cannot be value 5 because of a constraint issue with cell (7,4), which is a fact. And lastly, cell (8,3) cannot be the value 5 because of a constraint issue with cell (5,3), which is a fact.
