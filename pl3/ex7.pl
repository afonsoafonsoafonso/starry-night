myappend([], L, L).
myappend([X|L1], L2, [X|L3]):- 
    myappend(L1, L2, L3).

% ALÍNEA A)
before(A, B, L):-
    append(_,[A|L1],L),  
    append(_,[B|_],L1).