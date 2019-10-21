% ALÍNEA A)
substitui(_, _, [], []).

substitui(X, Y, [X|L1], [Y|L2]):-
    substitui(X, Y, L1, L2).

substitui(X, Y, [Z|L1], [Z|L2]):-
    Z\=X,
    substitui(X, Y, L1, L2).

% ALÍNEA B) (usando delete_all como função auxiliar)
delete_one(X, L, L1):-
    append(La, [X|Lb], L),
    append(La, Lb, L1).

delete_all(X, L, L):-
    \+ member(X,L).
delete_all(X, L1, L2):-
    delete_one(X, L1, L),
    delete_all(X, L, L2).

elimina_duplicados([], []).
elimina_duplicados([X|L1], [X|L2]):-
    delete_all(X, L1, L3),
    elimina_duplicados(L3, L2).