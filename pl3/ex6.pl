myappend([], L, L).
myappend([X|L1], L2, [X|L3]):- 
    myappend(L1, L2, L3).

% ALÍNEA A)
delete_one(X, L, L1):-
    myappend(La, [X|Lb], L),
    myappend(La, Lb, L1).

% ALÍNEA B)
delete_all(X, L, L):-
    \+ member(X,L).
delete_all(X, L1, L2):-
    delete_one(X, L1, L),
    delete_all(X, L, L2).


% ALÍNEA C)
delete_all_list([], L, L).
delete_all_list([X|LX], L1, L2):-
    delete_all(X, L1, L3),
    delete_all_list(LX, L3, L2).