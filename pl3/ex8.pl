% ALÍNEA A)
conta([], 0).
conta([A|L], N):-
    N1 is N-1,
    conta(L, N1).

% ALÍNEA B)
conta_elem(X, [], 0).

conta_elem(X, [X|L], N):-
    N1 is N-1,
    conta_elem(X,L,N1).

conta_elem(X, [A|L], N):-
    conta_elem(X, L, N).

    

    
