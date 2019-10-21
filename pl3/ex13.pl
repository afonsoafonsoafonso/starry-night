% ALÍNEA A)
lista_ate(0, []).
lista_ate(N, [N|L]):-
    N1 is N-1,
    lista_ate(N1, L).

% ALÍNEA B)
lista_entre(_, 0, []).
lista_entre(N1, N2, [N2|L]):-
    N3 is N2-1,
    lista_entre(N1, N3, L).

% ALÍNEA C)
soma_lista(L, S):-
    soma_lista1(L, 0, S).

soma_lista1([], S1, S):-
    S is S1.
soma_lista1([A|L], S1, S):-
    S2 is S1+A,
    soma_lista1(L, S2, S).

% ALÍNEA D)
par1(0).
par(N):-
    R is mod(N,2),
    par1(R).

% ALÍNEA E)
lista_pares(-1, []).

lista_pares(N, [N|L]):-
    par(N),
    N1 is N-1,
    lista_pares(N1, L).

lista_pares(N, L):-
    N1 is N-1,
    lista_pares(N1, L).

% ALÍNEA F)
lista_impares(-1, []).

lista_impares(N, [N|L]):-
    not(par(N)),
    N1 is N-1,
    lista_impares(N1, L).

lista_impares(N, L):-
    N1 is N-1,
    lista_impares(N1, L).


