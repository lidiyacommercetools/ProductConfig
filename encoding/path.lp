time(0..5).

stop(X,0):- 1{reason(X,X,fact,fact,0) ; reason(X,X,_,anti_fact,0)}, why(X,0).

stop(X,0):- 1{reason(X,X,fact,fact,0) ; reason(X,X,_,anti_fact,0)}, why_not(X,0).

stop(X,T):- why(X,T).
stop(X,T):- why_not(X,T).
stop(X,T+1):- stop(X,T), time(T+1).


path(X,Y,P,Z,T):- 1{why(X,T);why_not(X,T)}, reason(X,Y,P,Z,T).


:- path(X,Y',_,constraint,T), path(Y',Y',_,opt_choice,_), reason(X,Y,_,constraint,T), reason(Y,Y,_,fact,_).


knodes(N,X,T):- N= #count{P : reason(X,_,P,_,T)}, 1{why(X,T); why_not(X,T)}, time(T), assignment(X,_).

why(Y,T+1):-1{path(_,Y,_,rule_dependency,T);path(_,Y,_,rule_issue,T);path(_,Y,_,constraint,T)},time(T), 
answer(Y), not stop(Y,T'), time(T'), T'<(T+1).

why_not(Y,T+1):- 1{path(X,-Y,A,rule_dependency,T);path(X,Y,A,rule_issue_neg,T);path(X,-Y,A,constraint_neg,T)}, 
why_not(X,T), literal_tuple(_,W), assignment(Y,W), not answer(Y), not stop(Y,T'), time(T'), T'<(T+1).

why_not(Y,T+1):- path(X,-Y,A,rule_dependency,T), why(X,T), literal_tuple(_,W), assignment(Y,W), not answer(Y), not stop(Y,T'), time(T'), T'<(T+1).


why_not(Y,T+1):- path(X,X,P,mand_choice,T), not valid_option(Y,P), Y!=X, not stop(_,T), in_choice_rule(Y,_,P), not stop(Y,T'), time(T'), T'<(T+1).
why_not(Y,T+1):- path(X,Y,P,rule_issue_neg,T), not stop(Y,T'), time(T'), T'<(T+1).


why_choice_rule(P,0):- 1{path(X,X,P,opt_choice,0); path(X,X,P,choice_not,0)}, any_rule(P,_).
why_choice_rule(P,T):- 1{path(X,X,P,opt_choice,T); path(X,X,P,choice_not,T)}, time(T), any_rule(P,_).



#show path/5.
