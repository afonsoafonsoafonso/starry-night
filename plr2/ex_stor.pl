count_equals(_, [], 0).

count_equals(X, [Y|L], N):-
    X #= Y #<=> B,
    N #= M + B,
    exactly(X, L, M).