time(0..5).

stop(X,T):- {why(X,T); why_not(X,T)}=1, reason(X,_,_,_,T'), T'<T, time(T).

stop(X,0):- 1{reason(X,X,fact,fact,0) ; reason(X,X,_,anti_fact,0) ; 
reason(X,X,_,opt_choice,0) ; reason(X,X,_,opt_choice_not,0)}, why(X,0).

stop(X,0):- 1{reason(X,X,fact,fact,0) ; reason(X,X,_,anti_fact,0) ; 
reason(X,X,_,opt_choice,0) ; reason(X,X,_,opt_choice_not,0)}, why_not(X,0).

path(X,Y,P,Z,T):- 1{why(X,T);why_not(X,T)}, reason(X,Y,P,Z,T), knodes(1,X,T).
{path(X,P,T) : reason(X,_,P,_,T)}=1:- 1{why(X,T);why_not(X,T)}, knodes(N,X,T), N!=1.
path(X,Y,P,Z,T):- path(X,P,T), reason(X,Y,P,Z,T).


knodes(N,X,T):- N= #count{P : reason(X,_,P,_,T)}, 1{why(X,T); why_not(X,T)}, time(T), assignment(X,_).

why(Y,T+1):-1{path(_,Y,_,rule_dependency,T);path(_,Y,_,rule_issue,T);reason(_,Y,_,constraint,T)},time(T), 
answer(Y), not stop(_,T).

why_not(Y,T+1):- 1{path(X,-Y,A,rule_dependency,T);path(X,-Y,A,rule_issue_neg,T);reason(X,-Y,A,constraint_neg,T)}, 
time(T),not stop(X,T), answer(X), rule_unsatisfied_neg(_,_,Y).

why_not(Y,T+1):- path(X,-Y,A,rule_dependency,T), not stop(X,T), not answer(Y).
why_not(Y,T+1):- path(A,Y,_,rule_issue_neg,T).

why(Y,T+1):- reason(X,X,P,mand_choice,T), valid_choice(Y,P), Y!=X, not stop(X,T), not reason(X,X,fact,fact,T).
why_not(Y,T+1):- reason(X,X,P,mand_choice,T), why(X,T), 
in_choice_rule(Y,P), not valid_choice(Y,P), Y!=X,not stop(X,T),not reason(X,X,fact,fact,T).



#show path/5.
