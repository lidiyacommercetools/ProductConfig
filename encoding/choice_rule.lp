% multiple sums for heads P and P+1. This means that the lower range is not 0 and the max value is not the total possible max.
multi_sum(P):- rule(disjunction(P),sum(Q,Q1)),rule(disjunction(P+1),sum(Q,T)), Q1!=T.

% Count of atoms in a choice rule
num_choices(N,P):- N = #count{X : in_choice_rule(X,_,P)}, weighted_literal_tuple(P,_,_).

% the min and max number of choices to be made for choice rule Q
min_choices(Q1,Q):- multi_sum(P), rule(disjunction(P),sum(Q,Q1)), weighted_literal_tuple(Q,_,_).
%min_choices(N,V):- not multi_sum(P), rule(disjunction(P),sum(V,N)), rule(disjunction(P+1),normal(_)), not rule(disjunction(P+2),normal(_)).
min_choices(N,V):- not multi_sum(P), rule(disjunction(P),sum(V,N)).


%min_choices(T,Q):- not multi_sum(A), rule(disjunction(A),sum(Q,T)), atom_tuple(A,B), 
%literal_tuple(C,-B), rule(disjunction(V),normal(C)), not constraint1(V,C).
max_choices(T-1,Q) :- multi_sum(P), rule(disjunction(P+1),sum(Q,T)).
%max_choices(T-1,Q):- rule(disjunction(A),sum(Q,T)), not multi_sum(A), not min_choices(T,Q).
max_choices(N-1,V):- not multi_sum(P), rule(disjunction(P),sum(V,N)), rule(disjunction(P+1),normal(_)), rule(disjunction(P+2),normal(_)).

% Specific number of atoms to be chosen (not a range)  Q{}Q or {}=Q
specific_num_choices(A,P):- multi_sum(P), min_choices(A,Q), max_choices(B,Q), B=A.

% Range of atoms to be chosen A{}B-1
range_choices(A,B-1,P):- multi_sum(P), rule(disjunction(P),sum(Q,A)), rule(disjunction(P+1),sum(Q,B)).

% Atom is part of a choice rule

in_choice_rule(X,P,V):- rule(disjunction(P),sum(V,_)), weighted_literal_tuple(V,Z,_), assignment(X,Z).
in_choice_rule(X,P,V):- rule(choice(P),normal(V)), atom_tuple(V,Z), assignment(X,Z).


% An atom cannot be chosen in a choice rule if it is removed by a constraint
constraint1(P,V):- rule(disjunction(P),normal(V)), not atom_tuple(P,_), literal_tuple(V,Z), 
literal_tuple(Q,Z), output(_,Q).

in_constraint(X,V):- constraint1(P,V), literal_tuple(V,Z), literal_tuple(Q,Z), output(X,Q).
in_constraint(X,V):- constraint1(P,V), literal_tuple(V,-Z), literal_tuple(Q,Z), output(X,Q).

constraint_sat(X,V):- in_constraint(X,_,V), assignment(X,N), literal_tuple(V,N), not answer(X), not why(X,_).
constraint_sat(X,V):- in_constraint(X,_,V), assignment(X,N), literal_tuple(V,-N), answer(X), not why(X,_).


% An atom is a valid choice if it is not in any constraints
valid_option(X,P):- in_choice_rule(X,_,P), not in_constraint(X,_).

% An atom is a valid choice if it is part of a constraint that was already "satisfied"
valid_option(X,P):- in_choice_rule(X,_,P), in_constraint(X,V), constraint_sat(Y,V), Y!=X.


% Number of valid choices in the choice rule
num_val_opt(N,P):- N = #count{X : valid_option(X,P)}, weighted_literal_tuple(P,_,_).


% A choice can be made in a choice rule if it has a rule body and the body is satisfied {a}:-b.  b.
body_unsat(A):- rule(disjunction(A),normal(B)), literal_tuple(B,C), assignment(X,C), not answer(X).
body_unsat(A):- rule(disjunction(A),normal(B)), literal_tuple(B,-C), assignment(X,C), answer(X).
no_body(B):- rule(choice(A),normal(B)), not literal_tuple(B,_).
sat_choice_rule(P):- rule(disjunction(V),sum(P,_)), rule(disjunction(V-3),normal(_)), not body_unsat(V-3).
sat_choice_rule(P):- rule(disjunction(V),sum(P,_)), rule(disjunction(V-3),normal(B)), not literal_tuple(B,Q), assignment(Z,Q), answer(Z).
sat_choice_rule(P):- rule(disjunction(V),sum(P,_)), rule(disjunction(V-2),normal(B)), not literal_tuple(B,Q), assignment(Z,Q), answer(Z).

sat_choice_rule(P):- no_body(P).

% Option 1: Mandatory participation. {}=Q and there are Q valid options in the choice rule

option_one(P):- sat_choice_rule(P),num_val_opt(N,P), specific_num_choices(A,V),rule(disjunction(V),sum(P,_)), 
N=A.
choice_rule_option1(X,P,T):- why(X,T),valid_option(X,P), option_one(P), not fact(X),  not reason(X,_,_,rule_dependency,_).
reason(X,X,P,mand_choice,T):- choice_rule_option1(X,P,T).

% Option 2: Mandatory participation. Q{} and there are Q valid options in the choice rule

option_two(P):-sat_choice_rule(P),num_val_opt(N,P), min_choices(N,P).
choice_rule_option2(X,P,T):- why(X,T), option_two(P), valid_option(X,P), not fact(X), not reason(X,_,_,rule_dependency,_).
reason(X,X,P,mand_choice,T):- choice_rule_option2(X,P,T).

% Option 3: The choice made was optional.

choice_rule_option3(X,P,T):- why(X,T), sat_choice_rule(P),not option_one(P), not option_two(P), valid_option(X,P), not fact(X),  not reason(X,_,_,rule_dependency,_).
choice_rule_option3(X,A,T):- why(X,T),rule(choice(A),normal(B)), atom_tuple(A,Y), assignment(X,Y), not weighted_literal_tuple(_,Y,_), not fact(X),  not reason(X,_,_,rule_dependency,_).
reason(X,X,P,opt_choice,T):- choice_rule_option3(X,P,T).


% Are the first two options needed? Seems like the constraint and unsat body take priority
% Why was an atom not chosen in a choice rule? Constraint, body not satisfied, or choice rule.


chosen_in_choice(N,V,P):- N= #count{X: answer(X), in_choice_rule(X,V,P)}, rule(disjunction(V),sum(P,_)).
chosen_max(N,V,P):- chosen_in_choice(N,V,P), max_choices(N,P).
chosen_max_cons(V,P,X):- chosen_max(_,V,P), literal_tuple(P,Z), assignment(X,Z), anti_rule(X,_,_).



max_choices(T-1,Q) :- multi_sum(P), rule(disjunction(P+1),sum(Q,T)).
max_choices(T-1,Q):- rule(disjunction(A),sum(Q,T)), not multi_sum(A), not min_choices(T,Q).


choice_not(X,V,P,T):- why_not(X,T), in_choice_rule(X,V,P), sat_choice_rule(P), not reason(X,_,_,constraint,_), 
not reason(X,_,_,rule_issue,_), not reason(X,X,_,anti_fact,_), not reason(X,_,_,rule_issue_neg,_).
reason(X,X,V,choice_not,T):- choice_not(X,V,P,T).
