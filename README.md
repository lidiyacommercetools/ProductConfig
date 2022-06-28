# Explanation in Product Configuration Using Answer Set Programming

The goal of this project is to explain as to why a product is part of a presented configuration, or is left out. The encoding is done in Answer Set Programming (ASP) and uses clingo to compute the answer.

The code requires three inputs: problem encoding, the answer set that is under review, and the atom that the user would like to be explained.

The answer set should be in format : answer(a). answer(b). Where {a,b} is the answer set. If the answer set is empty, please include empty_set. in the input code.

The atom to be explained should be presented as: why(a). Where "a" is the atom the user would like to be explained.
