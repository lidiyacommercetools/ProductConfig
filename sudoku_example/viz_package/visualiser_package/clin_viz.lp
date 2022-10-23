% %%%%%%%%%%%%%%%%%%%%%%%%% Visualization
viz_graph(sudoku).

% Name of graph
viz_attr(graph, sudoku, name, "Sudoku").

% Global graph attributes
viz_attr(graph, sudoku, nodesep, 1).
viz_attr(graph, sudoku, newrank, true).

% Global node attributes
viz_attr(graph_nodes, sudoku, shape, square).
viz_attr(graph_nodes, sudoku, style, filled).
viz_attr(graph_nodes, sudoku, fillcolor, white).
viz_attr(graph_nodes, sudoku, width, "1").
viz_attr(graph_nodes, sudoku, fontsize, 30).

% Nodes
viz_node(pos(X,Y), sudoku):- pos(X,Y).
viz_attr(node, pos(X,Y), fillcolor, "grey88"):- pos(X,Y), subgrid(X,Y,S), S\2==0, not why(X,Y,_), not explain(sudoku(_,_,_),sudoku(X,Y,_)), not initial_unsat(X,Y,_).



viz_attr(node, pos(X,Y), label, " "):- sudoku(X,Y,V), not initial(X,Y,_), not why(X,Y,_).
viz_attr(node, pos(X,Y), (label,0), "<<B>"):- sudoku(X,Y,V), initial(X,Y,_),initial_unsat(X,Y,V).
viz_attr(node, pos(X,Y), (label,1), V):- sudoku(X,Y,V), initial(X,Y,_), initial_unsat(X,Y,V).
viz_attr(node, pos(X,Y), (label,2), "</B>>"):- sudoku(X,Y,V), initial(X,Y,_), initial_unsat(X,Y,V).
viz_attr(node, pos(X,Y), label, " "):- sudoku(X,Y,V), initial(X,Y,_), not initial_unsat(X,Y,V),not why(X,Y,_).

viz_attr(node, pos(X,Y), pos, @pos(X,Y)):- pos(X,Y).

% Edges to show subgrids
viz_edge((pos(X,Y),pos(X+1,Y)),sudoku):- pos(X,Y), pos(X+1,Y), subgrid(X,Y,S), subgrid(X+1,Y,S).
viz_edge((pos(X,Y),pos(X,Y+1)),sudoku):- pos(X,Y), pos(X,Y+1), subgrid(X,Y,S), subgrid(X,Y+1,S).


%mid(C,B):- explain(sudoku(A,B,_),sudoku(_,_,_)), values(C).
%mid(A,C):- explain(sudoku(A,B,_),sudoku(_,_,_)), values(C).
%mid(C,D):- explain(sudoku(A,B,_),sudoku(_,_,_)), subgrid(A,B,N), subgrid(C,D,N), (C,D)!=(A,B).

#const dim = 3.
values(1..dim*dim).



%viz_attr(node, pos(A,D), fillcolor, pink):- explain(sudoku(A,B,C),sudoku(_,_,_)), values(D).
%viz_attr(node, pos(D,B), fillcolor, pink):- explain(sudoku(A,B,C),sudoku(_,_,_)), values(D).
viz_attr(node, pos(X,Y), label, Z ):- explain(sudoku(_,_,_),sudoku(X,Y,Z)).

viz_attr(node, pos(X,Y), fontcolor, red):- explain(sudoku(_,_,_),sudoku(X,Y,Z)).
%viz_attr(node, pos(A',B'), fillcolor, pink):- explain(sudoku(A,B,C),sudoku(_,_,_)), subgrid(A,B,N), subgrid(A',B',N), (A,B)!=(A',B').

{viz_attr(node, pos(A,B), fillcolor, Z): colors(Z)}=1:- explain(sudoku(A,B,C),sudoku(_,_,_)).
%{viz_attr(node, pos(A,B), fillcolor, Z): colors(Z)}=1:- explain(sudoku(A,B,C),initial(A,B,_)).

viz_attr(node, pos(A,B), fillcolor, plum):- explain(sudoku(A,B,C),initial(A,B,_)).



%viz_attr(node, pos(A,D), fillcolor, Z):- explain(sudoku(A,B,C),sudoku(_,_,_)), values(D),viz_attr(node, pos(A,B), fillcolor, Z).
%viz_attr(node, pos(D,B), fillcolor, Z):- explain(sudoku(A,B,C),sudoku(_,_,_)), values(D),viz_attr(node, pos(A,B), fillcolor, Z).
%viz_attr(node, pos(A',B'), fillcolor, Z):- explain(sudoku(A,B,C),sudoku(_,_,_)), subgrid(A,B,N), subgrid(A',B',N), (A,B)!=(A',B'), values(D),viz_attr(node, pos(A,B), fillcolor, Z).


:-explain(sudoku(A,B,_),sudoku(_,_,_)), explain(sudoku(C,D,_),sudoku(_,_,_)), (A,B)!=(C,D), viz_attr(node, pos(A,B), fillcolor, Z),viz_attr(node, pos(C,D), fillcolor, Z).
:-explain(sudoku(A,B,_),sudoku(_,_,_)), explain(sudoku(C,D,_),initial(C,D,_)), (A,B)!=(C,D), viz_attr(node, pos(A,B), fillcolor, Z),viz_attr(node, pos(C,D), fillcolor, Z).

viz_attr(node, pos(C,D), fillcolor, Z):- explain(sudoku(A,B,_),sudoku(C,D,_)), viz_attr(node, pos(A,B), fillcolor, Z).



viz_attr(node, pos(X,Y), fillcolor, darkolivegreen1):- why(X,Y,_).
viz_attr(node, pos(X,Y), label, Z ):- why(X,Y,Z).
viz_attr(node, pos(X,Y), fontcolor, darkgreen):- why(X,Y,Z).
viz_attr(node, pos(X,Y), fontsize, "55pt"):- why(X,Y,Z).


viz_node(pos(X,0), sudoku):- pos(X,_).
viz_attr(node, pos(X,0), pos, @pos(X,0)):- pos(X,_).
viz_attr(node, pos(X,0), label, " "):- sudoku(X,_,_).
viz_attr(node, pos(X,0), color, white):- sudoku(X,_,_).

viz_edge((pos(X,Y),pos(X,Y-1)),sudoku):-explain(sudoku(_,_,_),sudoku(X,Y,Z)).
viz_attr(edge,(pos(X,Y),pos(X,Y-1)),dir, none):-explain(sudoku(_,_,_),sudoku(X,Y,Z)).
viz_attr(edge,(pos(X,Y),pos(X,Y-1)),color, black):-explain(sudoku(_,_,_),sudoku(X,Y,Z)).


colors(powderblue).  colors(peachpuff2). colors(pink). 
