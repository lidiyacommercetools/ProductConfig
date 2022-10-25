% %%%%%%%%%%%%%%%%%%%%%%%%% Visualization
viz_graph(sudoku).

% Name of graph
viz_attr(graph, sudoku, name, "Sudoku").

% Global graph attributes
viz_attr(graph, sudoku, nodesep, 1).
viz_attr(graph, sudoku, newrank, true).

viz_attr(graph, sudoku, label, Q):- chosen(Q).



% Global node attributes
viz_attr(graph_nodes, sudoku, shape, square).
viz_attr(graph_nodes, sudoku, style, filled).
viz_attr(graph_nodes, sudoku, fillcolor, white).
viz_attr(graph_nodes, sudoku, width, "1").
viz_attr(graph_nodes, sudoku, fontsize, 30).


viz_node(pos(X,Y), sudoku):- pos(X,Y).
viz_attr(node, pos(X,Y), pos, @pos(X,Y)):- pos(X,Y).

viz_edge((pos(X,Y),pos(X+1,Y)),sudoku):- pos(X,Y), pos(X+1,Y), subgrid(X,Y,S), subgrid(X+1,Y,S).
viz_edge((pos(X,Y),pos(X,Y+1)),sudoku):- pos(X,Y), pos(X,Y+1), subgrid(X,Y,S), subgrid(X,Y+1,S).


% Explanation for why cell


% Cells that eliminate themselves are plum
viz_attr(node, pos(X,Y), fillcolor, "plum"):- pos(X,Y), not why(X,Y,_), initial_unsat(X,Y,_), explain(sudoku(A,B,C),initial(X,Y,_)), chosen(0).

%Why cell is green
viz_attr(node, pos(X,Y), fillcolor, darkolivegreen1):- why(X,Y,_), chosen(0).


%The checkered pattern in grey

viz_attr(node, pos(X,Y), fillcolor, "grey88"):- pos(X,Y), subgrid(X,Y,S), S\2==0, 
not why(X,Y,_), 2= {not explain(sudoku(X,Y,_),sudoku(_,_,_)); not explain(sudoku(X,Y,_),initial(_,_,_))},
not derived(X,Y,_,_), chosen(0).


{viz_attr(node, pos(A,B), fillcolor, Z): colors(Z)}=1:- explain(_,sudoku(A,B,C)), chosen(0).
viz_attr(node, pos(A,B), fillcolor, Z):- explain(sudoku(A,B,C),sudoku(D,E,F)), viz_attr(node, pos(D,E), fillcolor, Z), chosen(0).

:- explain(sudoku(A,B,C),sudoku(D,E,F)), explain(sudoku(A',B',C'),sudoku(D,E,F)),
(A,B)!=(A',B'), viz_attr(node, pos(A,B), fillcolor, Z), 
not viz_attr(node, pos(A',B'), fillcolor, Z).

viz_attr(node, pos(A,B), fillcolor, pink):- explain(_,derived(A,B,_)), chosen(0).


viz_attr(node, pos(X,Y), label, " "):- sudoku(X,Y,V), not initial_unsat(X,Y,_), not why(X,Y,_), not explain(_,derived(X,Y,_)), chosen(0).
viz_attr(node, pos(X,Y), (label,0), "<<B>"):- initial_unsat(X,Y,V), 1{explain(_,sudoku(X,Y,V)); explain(_,initial(X,Y,V))}, chosen(0).
viz_attr(node, pos(X,Y), (label,1), V):- initial_unsat(X,Y,V), 1{explain(_,sudoku(X,Y,V)); explain(_,initial(X,Y,V))}, chosen(0).
viz_attr(node, pos(X,Y), (label,2), "</B>>"):- initial_unsat(X,Y,V), 1{explain(_,sudoku(X,Y,V)); explain(_,initial(X,Y,V))}, chosen(0).
viz_attr(node, pos(X,Y), label, " "):- sudoku(X,Y,V),initial_unsat(X,Y,_),not why(X,Y,_), 2= {not explain(_,sudoku(X,Y,V)); not explain(_,initial(X,Y,V))}, not explain(_,derived(X,Y,_)), chosen(0).


viz_attr(node, pos(X,Y), (label,0), "<<B>"):- explain(_,derived(X,Y,Z)), chosen(0).
viz_attr(node, pos(X,Y), (label,1), Z):- explain(_,derived(X,Y,Z)), chosen(0).
viz_attr(node, pos(X,Y), (label,2), "</B>>"):-  explain(_,derived(X,Y,Z)), chosen(0).





#const dim = 3.
values(1..dim*dim).




viz_attr(node, pos(X,Y), label, Z ):- why(X,Y,Z), chosen(0).
viz_attr(node, pos(X,Y), fontcolor, darkgreen):- why(X,Y,Z), chosen(0).
viz_attr(node, pos(X,Y), fontsize, "55pt"):- why(X,Y,Z), chosen(0).


viz_attr(node, pos(C,D), fillcolor, Z):- explain(sudoku(A,B,_),sudoku(C,D,_)), viz_attr(node, pos(A,B), fillcolor, Z), chosen(0).





colors(powderblue).  colors(peachpuff2). colors(red).

 

time(0..2).

% Explanations for derivations



viz_attr(node, pos(X,Y), label, " "):- sudoku(X,Y,V), not initial_unsat(X,Y,_), not why(X,Y,_), not explain(_,derived(X,Y,_)), chosen(0).
viz_attr(node, pos(X,Y), (label,0), "<<B>"):- initial_unsat(X,Y,V), 1{explain(_,sudoku(X,Y,V)); explain(_,initial(X,Y,V))}, chosen(0).
viz_attr(node, pos(X,Y), (label,1), V):- initial_unsat(X,Y,V), 1{explain(_,sudoku(X,Y,V)); explain(_,initial(X,Y,V))}, chosen(0).
viz_attr(node, pos(X,Y), (label,2), "</B>>"):- initial_unsat(X,Y,V), 1{explain(_,sudoku(X,Y,V)); explain(_,initial(X,Y,V))}, chosen(0).
viz_attr(node, pos(X,Y), label, " "):- sudoku(X,Y,V),initial_unsat(X,Y,_),not why(X,Y,_), 2= {not explain(_,sudoku(X,Y,V)); not explain(_,initial(X,Y,V))}, not explain(_,derived(X,Y,_)), chosen(0).



viz_attr(node, pos(X,Y), (label,0), "<<B>"):- chosen(T), T>0, derived(X,Y,Z,T).
viz_attr(node, pos(X,Y), (label,1), Z):- chosen(T), T>0, derived(X,Y,Z,T).
viz_attr(node, pos(X,Y), (label,2), "</B>>"):-  chosen(T), T>0, derived(X,Y,Z,T).

viz_attr(node, pos(X,Y), (label,0), "<<B>"):- 1{explain_der(_,initial(X,Y,Z),T); explain_der(_,sudoku(X,Y,Z),T)}, initial_unsat(X,Y,Z), chosen(T), T>0. 
viz_attr(node, pos(X,Y), (label,1), Z ):- 1{explain_der(_,initial(X,Y,Z),T); explain_der(_,sudoku(X,Y,Z),T)}, initial_unsat(X,Y,Z), chosen(T), T>0. 
viz_attr(node, pos(X,Y), (label,2), "</B>>"):- 1{explain_der(_,initial(X,Y,Z),T); explain_der(_,sudoku(X,Y,Z),T)}, initial_unsat(X,Y,Z), chosen(T), T>0. 

viz_attr(node, pos(X,Y), (label,0), "<<B>"):- chosen(T), T>0, derived(X,Y,Z,T'), T'<T. 
viz_attr(node, pos(X,Y), (label,1), Z ):- chosen(T), T>0, derived(X,Y,Z,T'), T'<T. 
viz_attr(node, pos(X,Y), (label,2), "</B>>"):- chosen(T), T>0, derived(X,Y,Z,T'), T'<T. 


viz_attr(node, pos(X,Y), label, " "):- chosen(T), T>0, not derived(X,Y,_,T), not explain_der(_,initial(X,Y,_),T), 
not explain_der(_,sudoku(X,Y,_),T), sudoku(X,Y,_), not derived(X,Y,_,T'), T'<T, time(T'), T'!=0 .

viz_attr(node, pos(X,Y), label, " "):- chosen(1), not derived(X,Y,_,1), not explain_der(_,initial(X,Y,_),1), 
not explain_der(_,sudoku(X,Y,_),1), sudoku(X,Y,_).

% Cells that eliminate themselves are plum

viz_attr(node, pos(X,Y), fillcolor, "plum"):- explain_der(_,initial(X,Y,_),T), chosen(T), T>0.

%Why cell is green
viz_attr(node, pos(X,Y), fillcolor, darkolivegreen1):- derived(X,Y,_,T), chosen(T), T>0.

viz_attr(node, pos(X,Y), fillcolor, pink):- derived(X,Y,_,T'),T'<T, chosen(T), T>0.

{viz_attr(node, pos(A,B), fillcolor, Z): colors(Z)}=1:- explain_der(_,sudoku(A,B,C),T), chosen(T), T>0.


viz_attr(node, pos(A,B), fillcolor, Z) :- chosen(T), T!=0, explain_der(sudoku(A,B,C),sudoku(D,E,F),T), viz_attr(node, pos(D,E), fillcolor, Z).

%viz_attr(node, pos(A,B), fillcolor, Z):- explain_der(sudoku(A,B,C),sudoku(D,E,F),T), viz_attr(node, pos(D,E), fillcolor, Z), chosen(T), T>0,
%not derived(D,E,_,_), not why(A,B,_).



viz_attr(node, pos(X,Y), fillcolor, "grey88"):- pos(X,Y), subgrid(X,Y,S), S\2==0, not explain_der(_,sudoku(X,Y,_),T),
not explain_der(sudoku(X,Y,_),_,T), chosen(T), not derived(X,Y,_,_), T>0.

%viz_attr(node, pos(X,Y), fillcolor, "grey88"):- why(X,Y,_), chosen(T), T>0.
