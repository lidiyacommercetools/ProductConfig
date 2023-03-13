%Numerical representation of an atom 
assignment(X,Y):- output(X,Q), literal_tuple(Q,Y).

why(X,0):- why(X).
why_not(X,0):- why_not(X).

%Numertical representation of the atom to be explained
why_assignment(X,D,T):- why(X,T),answer(X),assignment(X,D).


%Pick any rule type
any_rule(V,P):- 1{rule(disjunction(V),normal(P)); rule(choice(V),normal(P)); rule(choice(V),sum(P,_)); rule(disjunction(V),sum(P,_)) }1,
atom_tuple(V), literal_tuple(P).
any_choice_rule(V,P):- 1{rule(choice(V),normal(P)); rule(choice(V),sum(P,_))}1, atom_tuple(V), literal_tuple(P).
any_disjunction_rule(V,P):- 1{rule(disjunction(V),normal(P)); rule(disjunction(V),sum(P,_))}1, atom_tuple(V), literal_tuple(P).

