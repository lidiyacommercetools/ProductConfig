% %%%%%%%%%%%%%%%%%%%%%%%%% Visualization
viz_graph(X):- chosen_has_to(X,_,_).

% Name of graph
viz_attr(graph, X, name, X):- chosen_has_to(X,T,_).

% Global graph attributes
viz_attr(graph, X, nodesep, 1) :- chosen_has_to(X,_,_).
viz_attr(graph, X, newrank, true) :- chosen_has_to(X,_,_).

viz_attr(graph, X, label, X):-  chosen_has_to(X,T,_).


% Global node attributes
viz_attr(graph_nodes, X, shape, square):- chosen_has_to(X,T,_).
viz_attr(graph_nodes, X, style, filled):- chosen_has_to(X,T,_).
viz_attr(graph_nodes, X,  fillcolor, white):- chosen_has_to(X,T,_).
viz_attr(graph_nodes, X,  width, "1"):- chosen_has_to(X,T,_).
viz_attr(graph_nodes, X,  fontsize, 30):- chosen_has_to(X,T,_).


viz_node((pos(X,Y),Z), Z):- pos(X,Y), chosen_has_to(Z,T,_).

viz_attr(node,(pos(X,Y),Z), pos, @pos(X,Y)):- pos(X,Y),  chosen_has_to(Z,T,_).




viz_edge(((pos(X,Y), Z),(pos(X+1,Y), Z)),Z):- pos(X,Y), pos(X+1,Y), subgrid(X,Y,S), subgrid(X+1,Y,S), chosen_has_to(Z,T,_).
viz_edge(((pos(X,Y), Z),(pos(X,Y+1), Z)),Z):- pos(X,Y), pos(X,Y+1), subgrid(X,Y,S), subgrid(X,Y+1,S), chosen_has_to(Z,T,_).


% Explanation for why cell


% A cell is blank if it is not part of the unsat core, not the why cell, or was not derived

viz_attr(node, (pos(X,Y), sudoku(X',Y',N')), label, " "):- pos(X,Y), not initial_unsat(initial(X,Y,_)), 
not why(X,Y,_), not derived(X,Y,_,_), chosen_has_to(sudoku(X',Y',N'),0,_).


% A cell is blank if it was not used to explain a cell.
viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), label, " "):- chosen_has_to(sudoku(X,Y,V),0,_), why_not_derived(sudoku(X,Y,V), _,0),
not explain(_,sudoku(X'',Y'',_),0), not explain(_,initial(X'',Y'',_),0), not explain(_,derived(X'',Y'',_),0),
pos(X'',Y''), not why(X'',Y'',_).




% A cell is blank if it was derived but is not being used to explain the why cell

viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), label, " "):- chosen_has_to(sudoku(X,Y,V),0,_), why_not_derived(sudoku(X,Y,V), _,0), 
not explain(_,derived(X'',Y'',V''),0), derived(X'',Y'',V'',_), not initial_unsat(initial(X'',Y'',V'')).


viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), (label,0), "<<B>"):- initial_unsat(initial(X'',Y'',V'')), chosen_has_to(sudoku(X,Y,V),0,_), 
why_not_derived(sudoku(X,Y,V), sudoku(X',Y',V'),0),  1{explain(sudoku(X',Y',V') ,sudoku(X'',Y'',V''),0); 
explain(sudoku(X',Y',V'),initial(X'',Y'',V''),0); explain(sudoku(X',Y',V'),derived(X'',Y'',V''),0)}.


viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), (label,1), V''):- initial_unsat(initial(X'',Y'',V'')), chosen_has_to(sudoku(X,Y,V),0,_), 
why_not_derived(sudoku(X,Y,V), sudoku(X',Y',V'),0),  1{explain(sudoku(X',Y',V') ,sudoku(X'',Y'',V''),0); 
explain(sudoku(X',Y',V'),initial(X'',Y'',V''),0); explain(sudoku(X',Y',V'),derived(X'',Y'',V''),0)}.

viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), (label,2), "</B>>"):- initial_unsat(initial(X'',Y'',V'')), chosen_has_to(sudoku(X,Y,V),0,_), 
why_not_derived(sudoku(X,Y,V), sudoku(X',Y',V'),0),  1{explain(sudoku(X',Y',V') ,sudoku(X'',Y'',V''),0); explain(sudoku(X',Y',V'),initial(X'',Y'',V''),0);
explain(sudoku(X',Y',V'),derived(X'',Y'',V''),0)}.



viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), (label,0), "<<B>"):- derived(X'',Y'',V'',_), chosen_has_to(sudoku(X,Y,V),0,_), 
why_not_derived(sudoku(X,Y,V), sudoku(X',Y',V'),0),  1{explain(sudoku(X',Y',V') ,sudoku(X'',Y'',V''),0); 
explain(sudoku(X',Y',V'),initial(X'',Y'',V''),0); explain(sudoku(X',Y',V'),derived(X'',Y'',V''),0)}.


viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), (label,1), V''):- derived(X'',Y'',V'',_), chosen_has_to(sudoku(X,Y,V),0,_), 
why_not_derived(sudoku(X,Y,V), sudoku(X',Y',V'),0),  1{explain(sudoku(X',Y',V') ,sudoku(X'',Y'',V''),0); 
explain(sudoku(X',Y',V'),initial(X'',Y'',V''),0); explain(sudoku(X',Y',V'),derived(X'',Y'',V''),0)}.

viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), (label,2), "</B>>"):- derived(X'',Y'',V'',_), chosen_has_to(sudoku(X,Y,V),0,_), 
why_not_derived(sudoku(X,Y,V), sudoku(X',Y',V'),0),  1{explain(sudoku(X',Y',V') ,sudoku(X'',Y'',V''),0); explain(sudoku(X',Y',V'),initial(X'',Y'',V''),0);
explain(sudoku(X',Y',V'),derived(X'',Y'',V''),0)}.




viz_attr(node, (pos(X,Y),sudoku(X,Y,Z)), label, Z):- why(X,Y,Z), chosen_has_to(sudoku(X,Y,Z),0,_).
viz_attr(node, (pos(X,Y),sudoku(X,Y,Z)), fontcolor, darkgreen):- why(X,Y,Z), chosen_has_to(sudoku(X,Y,Z),0,_).
viz_attr(node, (pos(X,Y),sudoku(X,Y,Z)), fontsize, "55pt"):- why(X,Y,Z), chosen_has_to(sudoku(X,Y,Z),0,_).




% Cells that eliminate themselves are plum
viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), fillcolor, "plum"):- chosen_has_to(sudoku(X,Y,V),0,_), why_not_derived(sudoku(X,Y,V),sudoku(X',Y',V'),0), 
explain(sudoku(X',Y',V'),initial(X'',Y'',V''),0), initial_unsat(initial(X'',Y'',V'')), not why(X'',Y'',_).



%Why cell is green
viz_attr(node, (pos(X,Y),sudoku(X,Y,Z)), fillcolor, darkolivegreen1):- why(X,Y,Z), chosen_has_to(sudoku(X,Y,Z),0,_).


%The checkered pattern in grey


viz_attr(node, (pos(X',Y'),sudoku(X,Y,Z)), fillcolor, "grey88"):- chosen_has_to(sudoku(X,Y,Z),0,_), pos(X',Y'), subgrid(X',Y',S), S\2==0, 
not why(X',Y',_), not explain(sudoku(_,_,_),sudoku(X',Y',_),0), not explain(sudoku(_,_,_),initial(X',Y',_),0),
not explain(sudoku(_,_,_),derived(X',Y',_),0), not explain(sudoku(X',Y',_),_,0).


{viz_attr(node, (pos(A,B),Q), fillcolor, Z): colors(Z)}=1:- explain(_,sudoku(A,B,_),0), chosen_has_to(Q,0,_).


viz_attr(node, (pos(A,B),Q), fillcolor, Z):- chosen_has_to(Q,0,_), why_not_derived(Q,sudoku(A,B,N),0), 
explain(sudoku(A,B,N),sudoku(C,D,N'),0), viz_attr(node, (pos(C,D),Q), fillcolor, Z).



:- chosen_has_to(Q,0,_), why_not_derived(Q,sudoku(A,B,C),0), explain(sudoku(A,B,C),sudoku(D,E,F),0),
why_not_derived(Q,sudoku(A',B',C'),0), explain(sudoku(A',B',C'),sudoku(D,E,F),0),
(A,B)!=(A',B'), viz_attr(node, (pos(A,B),Q), fillcolor, Z), 
not viz_attr(node, (pos(A',B'),Q), fillcolor, Z).

:- chosen_has_to(Q,0,_), why_not_derived(Q,Y,0), explain(Y,sudoku(A,B,C),0), 
why_not_derived(Q,Y',0), explain(Y',sudoku(A',B',C'),0), (A,B,C)!= (A',B',C'), 
viz_attr(node, (pos(A,B),Q), fillcolor, Z), viz_attr(node, (pos(A',B'),Q), fillcolor, Z).


viz_attr(node, (pos(A,B),Q), fillcolor, pink):- chosen_has_to(Q,0,_), why_not_derived(Q,Q',0),
explain(Q',derived(A,B,_),0).


viz_attr(node, (pos(A,B),Q), fillcolor, Z):- chosen_has_to(Q,0,_), why_not_derived(Q, sudoku(A,B,_),0), 
explain(sudoku(A,B,_),derived(C,D,_),0), viz_attr(node, (pos(C,D),Q), fillcolor, Z).

#const dim = 3.
values(1..dim*dim).

colors(powderblue).  colors(peachpuff2). colors(red). colors(darksalmon). colors(gold2).
colors(darkorchid1).  
time(0..5).




% Explanations for derivations

% Cells that are not derived, or unsat core, or the why atom are left blank
viz_attr(node, (pos(X,Y), Q), label, " "):- pos(X,Y), not initial_unsat(initial(X,Y,_)), 
not why(X,Y,_), not derived(X,Y,_,_), chosen_has_to(Q,T,_), T>0.

viz_attr(node, (pos(X,Y), sudoku(X',Y',Z)), label, " "):- chosen_has_to(sudoku(X,Y,_),T,_), chosen_has_to(sudoku(X',Y',Z),T,_), (X,Y)!=(X',Y').

viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), label, " "):- chosen_has_to(sudoku(X,Y,V),T,_), why_not_derived(sudoku(X,Y,V), _,T),
not explain(_,sudoku(X'',Y'',_),T), not explain(_,initial(X'',Y'',_),T), not explain(_,derived(X'',Y'',_),T),
pos(X'',Y''), not why(X'',Y'',_), T>0, not derived(X'',Y'',_,T).


% Cells that are used in an explanation in time T but for a different derivation are blank
viz_attr(node, (pos(D,E), X'), label, " "):- explain(sudoku(A,B,C),sudoku(D,E,F),T), why_not_derived(X,sudoku(A,B,C),T), chosen_has_to(X,T,_),
chosen_has_to(X',T,_), X!=X', not viz_attr(node, (pos(D,E),X'), (label,1), F).

% Cells that are not used in an explanation in time T are blank
viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), label, " "):- chosen_has_to(sudoku(X,Y,V),T,_), why_not_derived(sudoku(X,Y,V), _,T),
not explain(_,sudoku(X'',Y'',_),T), not explain(_,initial(X'',Y'',_),T), not explain(_,derived(X'',Y'',_),T),
pos(X'',Y''), not why(X'',Y'',_), T>0, not derived(X'',Y'',_,T).


viz_attr(node, (pos(X,Y), W), label, " "):- chosen_has_to(Q,T,_), why_not_derived(Q,Q',T), explain(Q', initial(X,Y,Z),T), 
chosen_has_to(W,T,_), W!=Q, not why_not_derived(W,Q',T), T>0, not viz_attr(node, (pos(X,Y),W), (label,1), Z).



% The why cell is blank when T!=0
viz_attr(node, (pos(X,Y), Q), label, " "):- why(X,Y,_), chosen_has_to(Q,T,_), T!=0.


viz_attr(node, (pos(X,Y),Q), (label,0), "<<B>"):- T>0, chosen_has_to(Q,T,_), why_not_derived(Q,W,T), explain(W, initial(X,Y,Z),T).
viz_attr(node, (pos(X,Y),Q), (label,1), Z):-  T>0, chosen_has_to(Q,T,_), why_not_derived(Q,W,T), explain(W, initial(X,Y,Z),T).
viz_attr(node, (pos(X,Y),Q), (label,2), "</B>>"):-  T>0, chosen_has_to(Q,T,_), why_not_derived(Q,W,T), explain(W, initial(X,Y,Z),T).



viz_attr(node, (pos(X,Y),sudoku(X,Y,Z)), (label,0), "<<B>"):- T>0, chosen_has_to(sudoku(X,Y,Z),T,_), derived(X,Y,Z,T).
viz_attr(node, (pos(X,Y),sudoku(X,Y,Z)), (label,1), Z):-  T>0, chosen_has_to(sudoku(X,Y,Z),T,_), derived(X,Y,Z,T).
viz_attr(node, (pos(X,Y),sudoku(X,Y,Z)), (label,2), "</B>>"):-  T>0, chosen_has_to(sudoku(X,Y,Z),T,_), derived(X,Y,Z,T).

viz_attr(node, (pos(X'',Y''),sudoku(X,Y,Z)), (label,0), "<<B>"):- T>0, chosen_has_to(sudoku(X,Y,Z),T,_), why_not_derived(sudoku(X,Y,Z), sudoku(X',Y',Z'),T),
1{ explain(sudoku(X',Y',Z'),sudoku(X'',Y'',Z''),T); explain(sudoku(X',Y',Z'),derived(X'',Y'',Z''),T)}, 
initial_unsat(initial(X'',Y'',Z'')).

viz_attr(node, (pos(X'',Y''),sudoku(X,Y,Z)), (label,1), Z''):- T>0, chosen_has_to(sudoku(X,Y,Z),T,_), why_not_derived(sudoku(X,Y,Z), sudoku(X',Y',Z'),T),
1{ explain(sudoku(X',Y',Z'),sudoku(X'',Y'',Z''),T); explain(sudoku(X',Y',Z'),derived(X'',Y'',Z''),T)}, 
initial_unsat(initial(X'',Y'',Z'')).

viz_attr(node, (pos(X'',Y''),sudoku(X,Y,Z)), (label,2), "</B>>"):- T>0, chosen_has_to(sudoku(X,Y,Z),T,_), why_not_derived(sudoku(X,Y,Z), sudoku(X',Y',Z'),T),
1{ explain(sudoku(X',Y',Z'),sudoku(X'',Y'',Z''),T) ; explain(sudoku(X',Y',Z'),derived(X'',Y'',Z''),T)}, 
initial_unsat(initial(X'',Y'',Z'')).


viz_attr(node, (pos(X,Y),Q), (label,0), "<<B>"):-  T>0, derived(X,Y,Z,T'), T'<T, T'!=0, chosen_has_to(Q,T,_), why_not_derived(Q,Q',T), 
1={explain(Q',sudoku(X,Y,Z),T);explain(Q',derived(X,Y,Z),T) }.
viz_attr(node, (pos(X,Y),Q), (label,1), Z):-  T>0, derived(X,Y,Z,T'), T'<T, T'!=0, chosen_has_to(Q,T,_), why_not_derived(Q,Q',T), 
1={explain(Q',sudoku(X,Y,Z),T);explain(Q',derived(X,Y,Z),T) }.
viz_attr(node, (pos(X,Y),Q), (label,2), "</B>>"):- T>0, derived(X,Y,Z,T'), T'<T, T'!=0, chosen_has_to(Q,T,_), why_not_derived(Q,Q',T), 
1={explain(Q',sudoku(X,Y,Z),T);explain(Q',derived(X,Y,Z),T) }.






% Cells that eliminate themselves are plum


%Why cell is green
viz_attr(node, (pos(X,Y), sudoku(X,Y,Z)), fillcolor, darkolivegreen1):- chosen_has_to(sudoku(X,Y,Z),T,_), not why(X,Y,Z), T>0.


viz_attr(node, (pos(X'',Y''),sudoku(X,Y,V)), fillcolor, "plum"):- chosen_has_to(sudoku(X,Y,V),T,P), why_not_derived(sudoku(X,Y,V),sudoku(X',Y',V'),T), 
explain(sudoku(X',Y',V'),initial(X'',Y'',V''),T), initial_unsat(initial(X'',Y'',_)), not why(X'',Y'',_), T>0, P!= cell.




viz_attr(node, (pos(A,B),Q), fillcolor, pink):- chosen_has_to(Q,T,V), T>0, V!= cell, why_not_derived(Q,X,T), explain(X, sudoku(A,B,_),T),
derived(A,B,_,T'), T'<T.





{viz_attr(node, (pos(A,B),Q), fillcolor, Z): colors(Z)}=1:- chosen_has_to(Q,T,V), V!= cell, why_not_derived(Q,Q',T), T>0,
explain(Q',sudoku(A,B,_),T), not derived(A,B,_,_).


viz_attr(node, (pos(D,E),Q), fillcolor, Z):- chosen_has_to(Q,T,V), V!= cell, why_not_derived(Q,sudoku(D,E,N),T), T>0,
explain(sudoku(D,E,N),sudoku(A,B,N'),T), viz_attr(node, (pos(A,B),Q), fillcolor, Z).



:- chosen_has_to(X,T,V), V!= cell, why_not_derived(X,sudoku(A,B,C),T), explain(sudoku(A,B,C),Z,T), T>0,
why_not_derived(X,sudoku(A',B',C'),T), explain(sudoku(A',B',C'),Z,T),
(A,B,C)!=(A',B',C'), viz_attr(node, (pos(A,B),X), fillcolor, Z),
not viz_attr(node, (pos(A',B'),X), fillcolor, Z), Z!= "grey88".


:- chosen_has_to(X,T,V), V!= cell, why_not_derived(X,Z,T), explain(Z, sudoku(A,B,C),T), T>0,
chosen_has_to(X,T,V), why_not_derived(X,Z',T), explain(Z', sudoku(A',B',C'),T), Z!=Z',
(A,B,C)!=(A',B',C'), viz_attr(node, (pos(A,B),X), fillcolor, W), 
viz_attr(node, (pos(A',B'),X), fillcolor, W), W!= "grey88".


cannot_be_grey(A,B,sudoku(A,B,C),T):- chosen_has_to(sudoku(A,B,C),T,V), T>0.

cannot_be_grey(D,E,Q,T):- chosen_has_to(Q,T,V), T>0, why_not_derived(Q,sudoku(A,B,C),T),
explain(sudoku(A,B,C),sudoku(D,E,F),T).

cannot_be_grey(A,B,Q,T):- chosen_has_to(Q,T,V), T>0, why_not_derived(Q,sudoku(A,B,C),T).


cannot_be_grey(D,E,Q,T):- chosen_has_to(Q,T,V), T>0, why_not_derived(Q,sudoku(A,B,C),T),
explain(sudoku(A,B,C),initial(D,E,F),T).


cannot_be_grey(D,E,Q,T):- chosen_has_to(Q,T,V), T>0, why_not_derived(Q,sudoku(A,B,C),T),
explain(sudoku(A,B,C),derived(D,E,F),T).

viz_attr(node, (pos(X,Y),Q), fillcolor, "grey88"):- subgrid(X,Y,S), S\2==0, not cannot_be_grey(X,Y,Q,T), 
T>0, chosen_has_to(Q,T,V).

viz_attr(node, (pos(X,Y), Q), fillcolor, red):- chosen_has_to(Q,T,cell), why_not_derived(Q,W,T), explain(W,sudoku(X,Y,Z),T).



