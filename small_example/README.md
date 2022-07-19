## Example 1:

{b}.

{g}=1.

c:- g, f.

c:- b, f.

#external f.

answer(b). answer(c). answer(f). answer(g).

why(c).


![Image 7-19-22 at 7 49 PM](https://user-images.githubusercontent.com/81679574/179816407-dd4fb568-af43-452f-a98e-ed0f54169d5c.jpg)





![Image 7-19-22 at 7 58 PM](https://user-images.githubusercontent.com/81679574/179817768-3a54a0bf-2363-4b98-95ec-f3d87c87b40a.jpg)


## Example 2:

1{b;c}.

{d}.

:- b,d.

answer(b). answer(c).

why_not(d).

![Image 7-19-22 at 8 21 PM](https://user-images.githubusercontent.com/81679574/179821844-c0f496ac-f397-4417-bb71-040e7a3d6ea5.jpg)


Atom "d" is not part of the answer set because of a constraint with atom "b", which is part of the answer set. (:- b,d) And atom "b" is in the answer set because of being chosen in a choise rule. The choice was not mandatory.
