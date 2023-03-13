time(0..3).


% Pick a method of proof (column, row, or block) and derive the 8 why_not to explain


{method(row);method(column);method(subgrid)}=1.
why_not(sudoku(A,B,C)):- why(sudoku(D,E,C)), subgrid(D,E,N), subgrid(A,B,N), (A,B)!=(D,E), method(subgrid).
why_not(sudoku(D,E',C)):- why(sudoku(D,E,C)), val(E'), E!=E', method(row).
why_not(sudoku(D',E,C)):- why(sudoku(D,E,C)), val(D'), D!=D', method(column).

chosen_has_to(X,0,V):- why(X), method(V).
why_not_derived(X,Y,0):- why_not(Y), why(X).


% A cell is explained if a member of the unsat core or a derived value is located in the same cell

explain(sudoku(A,B,C),derived(A,B,D),0):- why_not(sudoku(A,B,C)), derived(A,B,D,_), not explain(sudoku(A,B,C),initial(A,B,_),0).
explain(sudoku(A,B,C),initial(A,B,D),0):- why_not(sudoku(A,B,C)), initial_unsat(initial(A,B,D)).



% A cell is explained if it is in a constraint with a member of the unsat core.

explain(sudoku(A,B,C), sudoku(A',B,C),0):- why_not(sudoku(A,B,C)), initial_unsat(initial(A',B,C)), A!=A'.
explain(sudoku(A,B,C), sudoku(A,B',C),0):- why_not(sudoku(A,B,C)), initial_unsat(initial(A,B',C)), B!=B'.
explain(sudoku(A,B,C), sudoku(A',B',C),0):- why_not(sudoku(A,B,C)), initial_unsat(initial(A',B',C)), (A,B)!=(A',B'), subgrid(A,B,N), subgrid(A',B',N).






% Given a sudoku(X,Y,N) that is part of the unsat core, row X cannot have another cell of value N,
% column Y cannot have another cell of value N, and the subgrid that (X,Y) belongs to cannot have another cell of value N.

cannot(sudoku(X,Y,N'), initial(X,Y,N),T):- initial_unsat(initial(X,Y,N)), N!=N', val(N'), time(T).
cannot(sudoku(X',Y,N), initial(X,Y,N),T):- initial_unsat(initial(X,Y,N)), val(X'), X!=X', time(T).
cannot(sudoku(X,Y',N), initial(X,Y,N),T):- initial_unsat(initial(X,Y,N)), val(Y'), Y!=Y', time(T).
cannot(sudoku(X',Y',N), initial(X,Y,N),T):- initial_unsat(initial(X,Y,N)), subgrid(X,Y,Z), 
subgrid(X',Y',Z), (X',Y')!= (X,Y), time(T).


% Given a derived(X,Y,N,T), for time T or any time prior to that (except 0) row X cannot have another cell of value N,
% column Y cannot have another cell of value N, and the subgrid that (X,Y) belongs to cannot have another cell of value N.

cannot(sudoku(X,Y,N'), derived(X,Y,N),T):- derived(X,Y,N,T), N!=N', val(N'), time(T), T!=0.
cannot(sudoku(X',Y,N), derived(X,Y,N),T):- derived(X,Y,N,T), val(X'), X!=X', time(T), T!=0.
cannot(sudoku(X,Y',N), derived(X,Y,N),T):- derived(X,Y,N,T), val(Y'), Y!=Y', time(T), T!=0.
cannot(sudoku(X',Y',N), derived(X,Y,N),T):- derived(X,Y,N,T), subgrid(X,Y,Z), 
subgrid(X',Y',Z), (X',Y')!= (X,Y), time(T), T!=0.


cannot(sudoku(X,Y,N'), derived(X,Y,N),T):- derived(X,Y,N,T'), N!=N', val(N'), time(T), T'<T.
cannot(sudoku(X',Y,N), derived(X,Y,N),T):- derived(X,Y,N,T'), val(X'), X!=X', time(T), T'<T.
cannot(sudoku(X,Y',N), derived(X,Y,N),T):- derived(X,Y,N,T'), val(Y'), Y!=Y', time(T), T'<T.
cannot(sudoku(X',Y',N), derived(X,Y,N),T):- derived(X,Y,N,T'), subgrid(X,Y,Z),
subgrid(X',Y',Z), (X',Y')!= (X,Y), time(T), T'<T.



% A cell (X,Y) can be of value N if there is no cannot(_,_,_) for cell (X,Y).
possible(X,Y,N,T):- not cannot(sudoku(X,Y,N),_,T), time(T), val(X), val(Y), val(N).


% Count the total number of times a value appears in the row/column/subgrid
count_row(X,N,Q,T):- Q= #count{Y,N,T: possible(X,Y,N,T)},val(X), val(N), time(T).
count_column(Y,N,Q,T):- Q= #count{X,N,T: possible(X,Y,N,T)},val(Y), val(N), time(T).
count_block(Z,N,Q,T):- Q= #count{X,Y,N,T: possible(X,Y,N,T), subgrid(X,Y,Z)}, val(N), val(Z), time(T).


% A cell (X,Y) has to be of value N if it is the only place in the row/column/subgrid that the value can be located

has_to(sudoku(A,B,C),T,subgrid):- count_block(Z,C,1,T), possible(A,B,C,T), subgrid(A,B,Z), not initial_unsat(initial(A,B,C)).
has_to(sudoku(A,B,C),T,row):- count_row(A,C,1,T), possible(A,B,C,T), not initial_unsat(initial(A,B,C)).
has_to(sudoku(A,B,C),T,column):- count_column(B,C,1,T), possible(A,B,C,T), not initial_unsat(initial(A,B,C)).


% A cell (X,Y) has to be of value N if the cell has only one option, N 

count_cell(X,Y,Q,T):- Q = #count{ X,Y,N: possible(X,Y,N,T)}, val(X), val(Y), time(T).
has_to(sudoku(A,B,C),T,cell):- count_cell(A,B,1,T), possible(A,B,C,T), not initial_unsat(initial(A,B,C)).


% A cell has been derived if there is only one possible value it can be, and it is not part of the unsat core or previously derived

derived(X,Y,Z,T+1):- has_to(sudoku(X,Y,Z),T,_), not initial_unsat(initial(X,Y,Z)), not already_derived(X,Y,Z,T), not why(sudoku(X,Y,Z)).

already_derived(X,Y,Z,T):- derived(X,Y,Z,T).
already_derived(X,Y,Z,T+1):- already_derived(X,Y,Z,T), time(T).

% Given that a cell has been derived, provide an explanation as to why
why_derived(sudoku(X,Y,Z),T):- derived(X,Y,Z,T).


{chosen_has_to(sudoku(X,Y,Z),T,V): has_to(sudoku(X,Y,Z),T-1,V)}=1:- derived(X,Y,Z,T).

why_not_derived(sudoku(D,E,C), sudoku(A,B,C),T):- why_derived(sudoku(D,E,C),T), subgrid(D,E,N), subgrid(A,B,N), (A,B)!=(D,E), chosen_has_to(sudoku(D,E,C),T,subgrid).
why_not_derived(sudoku(D,E,C), sudoku(D,E',C),T):- why_derived(sudoku(D,E,C),T), val(E'), E!=E', chosen_has_to(sudoku(D,E,C),T,row).
why_not_derived(sudoku(D,E,C), sudoku(D',E,C),T):- why_derived(sudoku(D,E,C),T), val(D'), D!=D', chosen_has_to(sudoku(D,E,C),T,column).
why_not_derived(sudoku(A,B,C), sudoku(A,B,C'),T):- why_derived(sudoku(A,B,C),T), chosen_has_to(sudoku(A,B,C),T,cell), val(C'), C!=C'.



{constraint_derived(P,V,Y,sudoku(A,B,C),T)}:- constraint(P,V), literal_tuple(V,Z), assignment(Y,Z), why_not_derived(_,Y,T),
assignment(sudoku(A,B,C),Z'), literal_tuple(V,Z'), initial_unsat(initial(A,B,C)), T>0.

{constraint_derived(P,V,Y,sudoku(A,B,C),T)}:- constraint(P,V), literal_tuple(V,Z), assignment(Y,Z), why_not_derived(_,Y,T),
assignment(sudoku(A,B,C),Z'), literal_tuple(V,Z'), derived(A,B,C,T'), T'<T, T'!=0, T>0.



% In the same spot as an initial
explain(sudoku(A,B,C), initial(A,B,D),T):- why_not_derived(_,sudoku(A,B,C),T), initial_unsat(initial(A,B,D)).

%In the same spot as a derived
explain(sudoku(A,B,C),sudoku(A,B,C'),T):- why_not_derived(_,sudoku(A,B,C),T), derived(A,B,C',T'), T'<T, T'!=0.


{explain(sudoku(A,B,C), sudoku(A',B,C),T)}:- why_not_derived(sudoku(X,Y,Z),sudoku(A,B,C),T), initial_unsat(initial(A',B,C)), A!=A'.
{explain(sudoku(A,B,C), sudoku(A,B',C),T)}:- why_not_derived(sudoku(X,Y,Z),sudoku(A,B,C),T), initial_unsat(initial(A,B',C)), B!=B'.
{explain(sudoku(A,B,C), sudoku(A',B',C),T)}:- why_not_derived(sudoku(X,Y,Z),sudoku(A,B,C),T), initial_unsat(initial(A',B',C)), (A,B)!=(A',B'), subgrid(A,B,N), subgrid(A',B',N).

:- why_not_derived(_,X,T), not explain(X,_,T), T>0, time(T).
:- explain(X,Y,T), explain(X,Y',T), Y!=Y'.
:- why_not(sudoku(A,B,C)), not explain(sudoku(A,B,C),_,0).




#show explain/3.
#show derived/4.
#show why_not_derived/3.
#show chosen_has_to/3.
