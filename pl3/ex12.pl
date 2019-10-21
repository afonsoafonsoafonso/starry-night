delete_one(X, L, L1):-
    append(La, [X|Lb], L),
    append(La, Lb, L1).

permutacao([], []).
permutacao([A|L1], L2):-
    delete_one(A, L2, L3),
    permutacao(L1, L3).

