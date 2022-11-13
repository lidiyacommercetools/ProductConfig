% Atom does not occur in a rule head
not_mentioned(X,T):- why_not(X,T), not output(X,_), not fact(X).
reason(X,X,not_mentioned,not_mentioned,T):- not_mentioned(X,T).

% Single constraint :-b. 

mult(X,P):- constraint(P,V,X,_), literal_tuple(V,Y), assignment(Z,Y), Z!=X.
anti_rule(X,P,T):- not mult(X,P), why_not(X,T), constraint(P,_,X,T).

reason(X,X,P,anti_fact,T):- anti_rule(X,P,T).


%Body of the rule was not satisfied

head_lit(X,A):- why_not(X,_), any_disjunction_rule(A,_), atom_tuple(A,C), assignment(X,C).
rule_unsatisfied_neg(V,P,X):- any_rule(V,P), literal_tuple(P,W), assignment(X,W), not answer(X).
rule_unsatisfied(V,P,X):- any_rule(V,P), literal_tuple(P,-W), assignment(X,W), answer(X).

rule_issue_neg(X,Y,A,T):- head_lit(X,A), why_not(X,T), rule_unsatisfied_neg(A,_,Y).
reason(X,-Y,A,rule_issue_neg,T):- rule_issue_neg(X,-Y,A,T).

rule_issue(X,Y,A,T):- head_lit(X,A), why_not(X,T), rule_unsatisfied(A,_,Y).
reason(X,Y,A,rule_issue,T):- rule_issue(X,Y,A,T).


% Constraint issue  

constraint(P,V):- rule(disjunction(P),normal(V)), not atom_tuple(P,_), literal_tuple(V,Z), 
literal_tuple(Q,Z), output(_,Q).

%Constraint and contains the why_not atom
constraint(P,V,Y,T):- constraint(P,V), literal_tuple(V,Z), assignment(Y,Z), why_not(Y,T).

% A constraint is satisfied and therefore is not used

constraint_sat(P,V,X,T):- constraint(P,V,Y,T), literal_tuple(V,B), assignment(X,B), not answer(X), X!=Y.
constraint_sat(P,V,X,T):- constraint(P,V,Y,T), literal_tuple(V,-B), assignment(X,B), answer(X), X!=Y.


% A constraint is not satisfied and includes the atom in question
constraint_why(P,V,Y,T):- not constraint_sat(P,V,_,T), constraint(P,V,Y,T).


{constraint_chosen(P,V,Y):constraint_why(P,V,Y,T)}=1:- why_not(Y,T), in_constraint(Y,_).


problem_atom(Y,W,P,V,T):- constraint_chosen(P,V,Y), why_not(Y,T), literal_tuple(V,Q), assignment(W,Q), answer(W).

problem_atom_neg(Y,W,P,V,T):- constraint_chosen(P,V,Y), why_not(Y,T), literal_tuple(V,-Q), assignment(W,Q), not answer(W).

reason(Y,W,P,constraint,T):- problem_atom(Y,W,P,V,T), why_not(Y,_).
reason(Y,W,P,constraint_neg,T):- problem_atom_neg(Y,W,P,V,T).
