#const dim = 3.
values(1..dim*dim).
colors(powderblue).  colors(peachpuff2). colors(red).
time(0..2).

% %%%%%%%%%%%%%%%%%%%%%%%%% Visualization
viz_graph(T):- explain(_,_,T).

% Name of graph
viz_attr(graph, T, name, T):- explain(_,_,T).

% Global graph attributes
viz_attr(graph, T, nodesep, 1) :- explain(_,_,T).
viz_attr(graph, T, newrank, true) :- explain(_,_,T).
viz_attr(graph, T, label, T):- explain(_,_,T).


% Global node attributes
viz_attr(graph_nodes, T, shape, square):- explain(_,_,T).
viz_attr(graph_nodes, T, style, filled):- explain(_,_,T).
viz_attr(graph_nodes, T, fillcolor, white):- explain(_,_,T).
viz_attr(graph_nodes, T, width, "1"):- explain(_,_,T).
viz_attr(graph_nodes, T, fontsize, 30):- explain(_,_,T).


viz_node((pos(X,Y),T), T):- pos(X,Y), explain(_,_,T).
viz_attr(node, (pos(X,Y),T), pos, @pos(X,Y)):- pos(X,Y), explain(_,_,T).

viz_edge(((pos(X,Y),T),(pos(X+1,Y),T)),T):- pos(X,Y), pos(X+1,Y), subgrid(X,Y,S), subgrid(X+1,Y,S), explain(_,_,T).
viz_edge(((pos(X,Y),T),(pos(X,Y+1),T)),T):- pos(X,Y), pos(X,Y+1), subgrid(X,Y,S), subgrid(X,Y+1,S), explain(_,_,T).



%%%% Explanation for why cell. explain(_,_,0)


% Cells that are not a part of the unsat core or are not used in the explanation are to not have a label
viz_attr(node, (pos(X,Y),0), label, " "):- sudoku(X,Y,V), not initial_unsat(initial(X,Y,_)), not why(X,Y,_), not derived(X,Y,_,_), explain(_,_,0).
viz_attr(node, (pos(X,Y),0), label, " "):- sudoku(X,Y,V),initial_unsat(initial(X,Y,_)),  not explain(_,sudoku(X,Y,V),0), not explain(_,initial(X,Y,V),0), not explain(_,derived(X,Y,_),0).

% Cells that are in the unsat core and are used in the explanation of the why cell are to be labeled with their value
viz_attr(node, (pos(X,Y),0), (label,0), "<<B>"):- initial_unsat(initial(X,Y,V)), 1{explain(_,sudoku(X,Y,V),0); explain(_,initial(X,Y,V),0)}.
viz_attr(node, (pos(X,Y),0), (label,1), V):- initial_unsat(initial(X,Y,V)), 1{explain(_,sudoku(X,Y,V),0); explain(_,initial(X,Y,V),0)}.
viz_attr(node, (pos(X,Y),0), (label,2), "</B>>"):- initial_unsat(initial(X,Y,V)), 1{explain(_,sudoku(X,Y,V),0); explain(_,initial(X,Y,V),0)}.

% Derived cells are to be labeled with their value
viz_attr(node, (pos(X,Y),0), (label,0), "<<B>"):- explain(_,derived(X,Y,Z),0).
viz_attr(node, (pos(X,Y),0), (label,1), Z):- explain(_,derived(X,Y,Z),0).
viz_attr(node, (pos(X,Y),0), (label,2), "</B>>"):-  explain(_,derived(X,Y,Z),0).


% The why cell is to be labeled with its value and to be colored green and bold
viz_attr(node, (pos(X,Y),0), label, Z):- why(X,Y,Z), explain(_,_,0).
viz_attr(node, (pos(X,Y),0), fontcolor, darkgreen):- why(X,Y,Z), explain(_,_,0).
viz_attr(node, (pos(X,Y),0), fontsize, "55pt"):- why(X,Y,Z), explain(_,_,0).


% Cells that eliminate themselves are plum
viz_attr(node, (pos(X,Y),0), fillcolor, "plum"):- not why(X,Y,_), initial_unsat(initial(X,Y,_)), explain(sudoku(A,B,C),initial(X,Y,_),0).


%Why cell is green
viz_attr(node, (pos(X,Y),0), fillcolor, darkolivegreen1):- why(X,Y,_), explain(_,_,0).


%The checkered pattern in grey to establish boundaries between the subgrids
viz_attr(node, (pos(X,Y),0), fillcolor, "grey88"):- pos(X,Y), subgrid(X,Y,S), S\2==0, 
not why(X,Y,_), 2= {not explain(sudoku(X,Y,_),sudoku(_,_,_),0); not explain(sudoku(X,Y,_),initial(_,_,_),0)},
not derived(X,Y,_,_), explain(_,_,0).


% A cell that explains, and the cells that are explained, are of the same color.
{viz_attr(node, (pos(A,B),0), fillcolor, Z): colors(Z)}=1:- explain(_,sudoku(A,B,C),0).
viz_attr(node, (pos(A,B),0), fillcolor, Z):- explain(sudoku(A,B,C),sudoku(D,E,F),0), viz_attr(node, (pos(D,E),T), fillcolor, Z).

:- explain(sudoku(A,B,C),sudoku(D,E,F),0), explain(sudoku(A',B',C'),sudoku(D,E,F),0),
(A,B)!=(A',B'), viz_attr(node, (pos(A,B),T), fillcolor, Z), 
not viz_attr(node, (pos(A',B'),T), fillcolor, Z).


% Derived cells are pink
viz_attr(node, (pos(A,B),0), fillcolor, pink):- explain(_,derived(A,B,_),0).
viz_attr(node, (pos(C,D),0), fillcolor, Z):- explain(sudoku(A,B,_),sudoku(C,D,_),0), viz_attr(node, (pos(A,B),0), fillcolor, Z).



%%%%%% Explanations for derivations

% Cells that are derived at time T, or before time T, are to be labeled with their value

viz_attr(node, (pos(X,Y),T), (label,0), "<<B>"):- explain(_,_,T), T>0, derived(X,Y,Z,T).
viz_attr(node, (pos(X,Y),T), (label,1), Z):- explain(_,_,T), T>0, derived(X,Y,Z,T).
viz_attr(node, (pos(X,Y),T), (label,2), "</B>>"):-  explain(_,_,T), T>0, derived(X,Y,Z,T).

viz_attr(node, (pos(X,Y),T), (label,0), "<<B>"):- explain(_,_,T), T>0, derived(X,Y,Z,T'), T'<T. 
viz_attr(node, (pos(X,Y),T), (label,1), Z):- explain(_,_,T), T>0, derived(X,Y,Z,T'), T'<T. 
viz_attr(node, (pos(X,Y),T), (label,2), "</B>>"):- explain(_,_,T), T>0, derived(X,Y,Z,T'), T'<T. 


% Cells that are part of the unsat core and used in the explanation of the derivation are to be labeled with their value
viz_attr(node, (pos(X,Y),T), (label,0), "<<B>"):- 1{explain(_,initial(X,Y,Z),T); explain(_,sudoku(X,Y,Z),T)}, initial_unsat(initial(X,Y,Z)), T>0, time(T). 
viz_attr(node, (pos(X,Y),T), (label,1), Z):- 1{explain(_,initial(X,Y,Z),T); explain(_,sudoku(X,Y,Z),T)}, initial_unsat(initial(X,Y,Z)), T>0, time(T). 
viz_attr(node, (pos(X,Y),T), (label,2), "</B>>"):- 1{explain(_,initial(X,Y,Z),T); explain(_,sudoku(X,Y,Z),T)}, initial_unsat(initial(X,Y,Z)), T>0, time(T). 


viz_attr(node, (pos(X,Y),T), label, " "):- explain(_,_,T), T>1, not derived(X,Y,_,T), not explain(_,initial(X,Y,_),T), 
not explain(_,sudoku(X,Y,_),T), sudoku(X,Y,_), not derived(X,Y,_,T'), T'<T, time(T'), T'!=0 .

viz_attr(node, (pos(X,Y),1), label, " "):- explain(_,_,1), not derived(X,Y,_,1), not explain(_,initial(X,Y,_),1), 
not explain(_,sudoku(X,Y,_),1), sudoku(X,Y,_).



% Cells that eliminate themselves are plum

viz_attr(node, (pos(X,Y),T), fillcolor, "plum"):- explain(_,initial(X,Y,_),T), T>0.

%Why cell is green
viz_attr(node, (pos(X,Y),T), fillcolor, darkolivegreen1):- derived(X,Y,_,T), explain(_,_,T), T>0.

% Derived cells are pink
viz_attr(node, (pos(X,Y),T), fillcolor, pink):- derived(X,Y,_,T'),T'<T, explain(_,_,T), T>0.


% A cell that explains, and the cells that are explained, are of the same color.
{viz_attr(node, (pos(A,B),T), fillcolor, Z): colors(Z)}=1:- explain(_,sudoku(A,B,C),T), T>0.
viz_attr(node, (pos(A,B),T), fillcolor, Z) :- T!=0, explain(sudoku(A,B,C),sudoku(D,E,F),T), viz_attr(node, (pos(D,E),T), fillcolor, Z).


viz_attr(node, (pos(X,Y),T), fillcolor, "grey88"):- pos(X,Y), subgrid(X,Y,S), S\2==0, not explain(_,sudoku(X,Y,_),T),
not explain(sudoku(X,Y,_),_,T), not derived(X,Y,_,_), T>0, time(T).

