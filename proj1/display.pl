% Avaliação Intercalar PLOG
% Game: Xero-G
% by Afonso Mendonça & Filipe Nogueira

% example of possible board at game start
startBoard([
    ['A', 'A', 'A', 'A', 'A', 'A'],
    [ 3 ,  2 ,  1 ,  3 ,  1 ,  2 ],
    [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
    [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
    [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
    [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
    [ 1 ,  3 ,  2 ,  2 ,  3 ,  1 ],
    ['B', 'B', 'B', 'B', 'B', 'B']
    ]).

% example of possible board at mid game
midBoard([
    ['A', 'A', 'A', 'A', 'A', 'A'],
    [ 0 ,  0 ,  1 ,  0 ,  0 ,  2 ],
    [ 3 ,  0 ,  0 ,  3 ,  1 ,  0 ],
    [ 0 ,  0 ,  0 ,  0 ,  0 ,  3 ],
    [ 0 ,  0 ,  3 ,  0 ,  2 ,  0 ],
    [ 0 ,  2 ,  0 ,  0 ,  0 ,  1 ],
    [ 1 ,  0 ,  2 ,  0 ,  0 ,  0 ],
    ['B', 'B', 'B', 'B', 'B', 'B']
    ]).

%example of possible board at end game (player B win    )
endBoard([
    ['A', 'A',  2, 'A', 'A', 'A'],
    [ 0 ,  0 ,  1 ,  0 ,  0 ,  2 ],
    [ 3 ,  0 ,  0 ,  3 ,  1 ,  0 ],
    [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
    [ 1 ,  0 ,  3 ,  0 ,  3 ,  1 ],
    [ 0 ,  2 ,  0 ,  0 ,  0 ,  0 ],
    [ 0 ,  0 ,  0 ,  0 ,  2 ,  0 ],
    ['B', 'B', 'B', 'B', 'B', 'B']
    ]).

display_startBoard:-
    startBoard(B),
    display_game(B,'A').

display_midBoard:-
    midBoard(B),
    display_game(B,'B').

display_endBoard:-
    endBoard(B),
    display_game(B, 'A').

display_game(B, P):-
    nl,
    write('TURN: '),
    write(P),
    nl,
    write('     0   1   2   3   4   5 \n'),
    write('  -|---|---|---|---|---|---|'),
    display_matrix(B, 0).

display_matrix([], _).
display_matrix([H|T], Nrow):-
    write('\n '),
    write(Nrow),
    write(' | '),
    Nrow1 is Nrow+1,
    display_row(H, Nrow1),
    nl,
    write('  -|---|---|---|---|---|---|'),
    display_matrix(T, Nrow1).

display_row([], _).
display_row([H|T], Nrow):-
    write(H),
    write(' | '),
    display_row(T, Nrow).

    

