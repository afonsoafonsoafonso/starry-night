% ALINEA A)
mymember(X,[X|T]).
mymember(X,[Y|L]):-
    mymember(X,L).
% ex:
a:-mymember(14, [1,2,3,4,5,6,7]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myappend([], L, L).
myappend([X|L1], L2, [X|L3]) :- myappend(L1, L2, L3).

% ALINEA B)
mymember2(X,L):- 
    myappend(_, [X|_], L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ALINEA C)


