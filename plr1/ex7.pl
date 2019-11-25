:-use_module(library(clpfd)).

perus(R):-
    L=[A,6,7,D],
    A in(1,9),
    B in(0,9),
    N #= A*1000 + 670 + D,
    N mod 72 #= 0,
    R #= N / 72,
    labeling([], L).
    
