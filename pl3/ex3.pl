myappend([], L, L).
myappend([X|L1], L2, [X|L3]) :- my  append(L1, L2, L3).