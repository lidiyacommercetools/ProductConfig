time(0..3).


% Pick a method of proof (column, row, or block) and derive the 8 why_not to explain


{method(row);method(column);method(cell)}=1.
why_not(sudoku(A,B,C)):- why(sudoku(D,E,C)), subgrid(D,E,N), subgrid(A,B,N), (A,B)!=(D,E), method(cell).
why_not(sudoku(D,E',C)):- why(sudoku(D,E,C)), val(E'), E!=E', method(row).
why_not(sudoku(D',E,C)):- why(sudoku(D,E,C)), val(D'), D!=D', method(column).



% A cell is explained if a member of the unsat core or a derived value is located in the same cell

explain(sudoku(A,B,C),derived(A,B,D),0):- why_not(sudoku(A,B,C)), derived(A,B,D,_), not explain(sudoku(A,B,C),initial(A,B,_),0).
explain(sudoku(A,B,C),initial(A,B,D),0):- why_not(sudoku(A,B,C)), initial_unsat(initial(A,B,D)).



% A cell is explained if it is in a constraint with a member of the unsat core.

assignment(X,Y):- output(X,Q), literal_tuple(Q,Y).
constraint(P,V):- rule(disjunction(P),normal(V)), not atom_tuple(P,_), literal_tuple(V,Z), 
literal_tuple(Q,Z), output(_,Q).
constraint(P,V,Y):- constraint(P,V), literal_tuple(V,Z), assignment(Y,Z).

explain(sudoku(A,B,C), sudoku(D,E,F),0):- why_not(sudoku(A,B,C)), initial_unsat(initial(D,E,F)), 
constraint(P,V,sudoku(A,B,C)),  constraint(P,V,sudoku(D,E,F)), not explain(sudoku(A,B,C),initial(A,B,_),0).



% Every why_not has to be explained
:- why_not(sudoku(A,B,C)), not explain(sudoku(A,B,C),_,0).


% A cell can be explained using only the members on the unsat core
:- explain(_,sudoku(A,B,C),_), not initial_unsat(initial(A,B,C)).
:- explain(_,initial(A,B,C),_), not initial_unsat(initial(A,B,C)).




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


% Count the total number of values a cell (X,Y) can be
count_row(X,N,Q,T):- Q= #count{Y,N,T: possible(X,Y,N,T)},val(X), val(N), time(T).
count_column(Y,N,Q,T):- Q= #count{X,N,T: possible(X,Y,N,T)},val(Y), val(N), time(T).
count_block(Z,N,Q,T):- Q= #count{X,Y,N,T: possible(X,Y,N,T), subgrid(X,Y,Z)}, val(N), val(Z), time(T).


% A cell (X,Y) has to be of value N if the cell has only one option, N 

has_to(sudoku(A,B,C),T,cell):- count_block(Z,C,1,T), possible(A,B,C,T), subgrid(A,B,Z), not initial_unsat(initial(A,B,C)).
has_to(sudoku(A,B,C),T,row):- count_row(A,C,1,T), possible(A,B,C,T), not initial_unsat(initial(A,B,C)).
has_to(sudoku(A,B,C),T,column):- count_column(B,C,1,T), possible(A,B,C,T), not initial_unsat(initial(A,B,C)).


% A cell has been derived if there is only one possible value it can be, and it is not part of the unsat core or previously derived
derived(X,Y,Z,1):- has_to(sudoku(X,Y,Z),0,_), not initial_unsat(initial(X,Y,Z)).
derived(X,Y,Z,T+1):- has_to(sudoku(X,Y,Z),T,_), not initial_unsat(initial(X,Y,Z)), T!=0, {not derived(X,Y,Z,T')}=T, time(T'), 
T'<=T, T'!=0, not stop(T''), T''<T, time(T'').

stop(T) :- why(sudoku(A,B,C)), derived(A,B,C,T).

% Given that a cell has been derived, provide an explanation as to why
why_derived(sudoku(X,Y,Z),T):- derived(X,Y,Z,T).


{chosen_has_to(sudoku(X,Y,Z),T,V): has_to(sudoku(X,Y,Z),T-1,V)}=1:- derived(X,Y,Z,T).
why_not_derived(sudoku(A,B,C),T):- why_derived(sudoku(D,E,C),T), subgrid(D,E,N), subgrid(A,B,N), (A,B)!=(D,E), chosen_has_to(sudoku(D,E,C),T,cell).
why_not_derived(sudoku(D,E',C),T):- why_derived(sudoku(D,E,C),T), val(E'), E!=E', chosen_has_to(sudoku(D,E,C),T,row).
why_not_derived(sudoku(D',E,C),T):- why_derived(sudoku(D,E,C),T), val(D'), D!=D', chosen_has_to(sudoku(D,E,C),T,column).
constraint_derived(P,V,Y,T):- constraint(P,V), literal_tuple(V,Z), assignment(Y,Z), why_not_derived(Y,T).


explain(sudoku(A,B,C),sudoku(D,E,F),T):- constraint_derived(P,V,sudoku(A,B,C),T), literal_tuple(V,Z), 
assignment(sudoku(D,E,F),Z), sudoku(D,E,F)!= sudoku(A,B,C), not initial_unsat(initial(A,B,_)), initial_unsat(initial(D,E,F)), not why(sudoku(D,E,F)), not derived(D,E,F,T).

explain(sudoku(A,B,C), initial(A,B,D),T):- why_not_derived(sudoku(A,B,C),T), initial_unsat(initial(A,B,D)).



#show explain/3.
#show derived/4.

