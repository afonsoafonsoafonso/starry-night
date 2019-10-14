myappend([], L, L).
myappend([X|L1], L2, [X|L3]):- 
    myappend(L1, L2, L3).

delete_one(X, L, L1):-
    myappend(La, [X|Lb], L),
    myappend(La, Lb, L1).

% não funciona bem bem bem. continua para sempre
% o processo de eliminação???
delete_all(X, L, L).
delete_all(X, L1, L2):-
    delete_one(X, L1, L),
    delete_all(X, L, L2).


