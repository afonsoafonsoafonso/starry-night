% ALÍNEA A)
substitui(_, _, [], []).

substitui(X, Y, [X|L1], [Y|L2]):-
    substitui(X, Y, L1, L2).

substitui(X, Y, [Z|L1], [Z|L2]):-
    Z\=X,
    substitui(X, Y, L1, L2).

% ALÍNEA B)
    