% Atom X depends on atom Y in rule P, where P represents the body of the rule (  X:- Y  )

rule_unsatisfied(P):- any_rule(V,P), literal_tuple(P,W), assignment(X,W), not answer(X).
rule_unsatisfied(P):- any_rule(V,P), literal_tuple(P,-W), assignment(X,W), answer(X).

depends(X,Y,P,T):- why_assignment(X,N,T), answer(Y), assignment(Y,Q), literal_tuple(P,Q),  
any_disjunction_rule(V,P), atom_tuple(V,N), not rule_unsatisfied(P), not fact(X).

reason(X,Y,P,rule_dependency,T):- depends(X,Y,P,T).

% Atom X depends on the negation of atom Y in rule C, where C is the head of the rule ( X :- not Y.  )

depends_neg(X,Y,A,T):- why_assignment(X,D,T), not answer(Y), assignment(Y,B), literal_tuple(A,-B), 
any_disjunction_rule(C,A), atom_tuple(C,D), not rule_unsatisfied(A).

reason(X,-Y,A,rule_dependency,T):- depends_neg(X,Y,A,T).

% Atom is a fact

fact(X):- output(X,Y), literal_tuple(Y,Z), external(Z,false).

reason(X,X,fact,fact,T):- fact(X), why(X,T).

