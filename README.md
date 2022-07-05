# Explanation in Product Configuration Using Answer Set Programming

The goal of this project is to explain as to why a product is part of a presented configuration, or is left out. The encoding is done in Answer Set Programming (ASP) and uses clingo to compute the answer.

The code requires three inputs: problem encoding, the answer set that is under review, and the atom that the user would like to be explained.

The answer set should be in format : answer(a). answer(b). Where {a,b} is the answer set. If the answer set is empty, please include empty_set. in the input code.

The atom to be explained should be presented as: why(a). Where "a" is the atom the user would like to be explained.

Facts for the particular case of the encoding need to be included in a separate file from the actual problem encoding. This is due to grounding. If the facts are included in the encoding, they will not be used in the explanation. Therefore, File One should include the problem encoding, and File Two should include the why(), answer(), as well as facts in the format fact(). An example can be found in the Sudoku encoding in the repository.
