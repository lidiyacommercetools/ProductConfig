% multiple sums for heads P and P+1. This means that the lower range is not 0 and the max value is not the total possible max.
multi_sum(P):- rule(disjunction(P),sum(Q,Q1)),rule(disjunction(P+1),sum(Q,T)), Q1!=T.

% Count of atoms in a choice rule
num_choices(N,P):- N = #count{X : in_choice_rule(X,P)}, weighted_literal_tuple(P,_,_).

% the min and max number of choices to be made for choice rule Q
min_choices(Q1,Q):- multi_sum(P), rule(disjunction(P),sum(Q,Q1)), weighted_literal_tuple(Q,_,_).
min_choices(Q1,Q):- not multi_sum(P-1), rule(disjunction(P),sum(Q,Q1)), weighted_literal_tuple(Q,_,_).

%min_choices(T,Q):- not multi_sum(A), rule(disjunction(A),sum(Q,T)), atom_tuple(A,B), 
%literal_tuple(C,-B), rule(disjunction(V),normal(C)), not constraint1(V,C).
max_choices(T-1,Q) :- multi_sum(P), rule(disjunction(P+1),sum(Q,T)).
max_choices(T-1,Q):- rule(disjunction(A),sum(Q,T)), not multi_sum(A), not min_choices(T,Q).


% Specific number of atoms to be chosen (not a range)  Q{}Q or {}=Q
specific_num_choices(A,P):- multi_sum(P), min_choices(A,Q), max_choices(B,Q), B=A.

% Range of atoms to be chosen A{}B-1
range_choices(A,B-1,P):- multi_sum(P), rule(disjunction(P),sum(Q,A)), rule(disjunction(P+1),sum(Q,B)).

% Atom is part of a choice rule

in_choice_rule(X,P):- assignment(X,Y), weighted_literal_tuple(P,Y,_).

% An atom cannot be chosen in a choice rule if it is removed by a constraint
constraint1(P,V):- rule(disjunction(P),normal(V)), not atom_tuple(P,_), literal_tuple(V,Z), 
literal_tuple(Q,Z), output(_,Q).

in_constraint(X,V):- constraint1(P,V), literal_tuple(V,Z), literal_tuple(Q,Z), output(X,Q).
in_constraint(X,V):- constraint1(P,V), literal_tuple(V,-Z), literal_tuple(Q,Z), output(X,Q).

constraint_sat1(X,V):- in_constraint(X,V), assignment(X,N), literal_tuple(V,N), not answer(X), not why(X,_).
constraint_sat1(X,V):- in_constraint(X,V), assignment(X,N), literal_tuple(V,-N), answer(X), not why(X,_).


% An atom is a valid choice if it is not in any constraints
valid_choice(X,P):- in_choice_rule(X,P), not in_constraint(X,_), not fact(X).

% An atom is a valid choice if it is part of a constraint that was already "satisfied"
valid_choice(X,P):- in_choice_rule(X,P), in_constraint(X,V), constraint_sat1(Y,V), Y!=X, not fact(X).

% Number of valid choices in the choice rule
num_valid_choices(N,P):- N = #count{X : valid_choice(X,P)}, weighted_literal_tuple(P,_,_).


% A choice can be made in a choice rule if it has a rule body and the body is satisfied {a}:-b.  b.
body_unsat(A):- rule(disjunction(A),normal(B)), literal_tuple(B,C), assignment(X,C), not answer(X).
body_unsat(A):- rule(disjunction(A),normal(B)), literal_tuple(B,-C), assignment(X,C), answer(X).
no_body(A):- rule(disjunction(A),normal(B)), not atom_tuple(A,_).
sat_choice_rule(P):- rule(disjunction(V),sum(P,_)), rule(disjunction(V-3),normal(_)), not body_unsat(V-3).
sat_choice_rule(P):- rule(disjunction(V),sum(P,_)), rule(disjunction(V-3),normal(B)), not literal_tuple(B,_).

% Option 1: Mandatory participation. {}=Q and there are Q valid options in the choice rule

option_one(P):- sat_choice_rule(P),num_valid_choices(N,P), specific_num_choices(A,V),rule(disjunction(V),sum(P,_)), N=A.
choice_rule_option1(X,P,T):- why(X,T),valid_choice(X,P), option_one(P), not fact(X).
reason(X,X,P,mand_choice,T):- choice_rule_option1(X,P,T).

% Option 2: Mandatory participation. Q{} and there are Q valid options in the choice rule

option_two(P):-1{sat_choice_rule(P);no_body(V)},num_valid_choices(N,P), min_choices(N,P).
choice_rule_option2(X,P,T):- why(X,T), option_two(P), valid_choice(X,P), not fact(X).
reason(X,X,P,mand_choice,T):- choice_rule_option2(X,P,T).

% Option 3: The choice made was optional.

choice_rule_option3(X,P,T):- why(X,T), 1{sat_choice_rule(P);no_body(V)},not option_one(P), not option_two(P), valid_choice(X,P), not fact(X).
choice_rule_option3(X,A,T):- why(X,T),rule(choice(A),normal(B)), atom_tuple(A,Y), assignment(X,Y), not weighted_literal_tuple(_,Y,_).
reason(X,X,P,opt_choice,T):- choice_rule_option3(X,P,T).


% Are the first two options needed? Seems like the constraint and unsat body take priority
% Why was an atom not chosen in a choice rule? Constraint, body not satisfied, or optional choice was made.
option_one_not(X,P):- why_not(X,T), not valid_choice(X,_), in_constraint(X,P).
option_two_not(X,P):- why_not(X,T), not sat_choice_rule(P), in_choice_rule(X,P).
option_three_not(X,P,T):- why_not(X,T), not option_one_not(X,_), not option_two_not(X,_), in_choice_rule(X,P), not reason(X,_,_,constraint,_).
reason(X,X,P,opt_choice_not,T):- option_three_not(X,P,T).

