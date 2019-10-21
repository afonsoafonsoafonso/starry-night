% ALÍNEA A)
ordenada([]).
ordenada([_]).
ordenada([A,B|L]):-
    A=<B,
    ordenada([B|L]).

% ALÍNEA B) à trolha
ordena(L1,L2):-
    permutation(L1, L2),
    ordenada(L2).


    


