startBoard([
        [-1 , -1 , -1 , -1 , -1 , -1 ],
        [ 3 ,  2 ,  1 ,  3 ,  1 ,  2 ],
        [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
        [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
        [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
        [ 0 ,  0 ,  0 ,  0 ,  0 ,  0 ],
        [ 1 ,  3 ,  2 ,  2 ,  3 ,  1 ],
        [-2 , -2 , -2 , -2 , -2 , -2 ]
        ]).

board_setup(B, P):-
    startBoard(B),
    P is 1.

start_game():-
    board_setup(B, P),
    game_loop(B, P).

game_loop(B, P):-
    display_game(B, P),
    % TO-DO: verificar se há vencedor
    % pede por um move do user
    get_move(X1, Y1, X2, Y2),
    write('X1: '),
    write(X1),
    nl,
    write('Y1: '),
    write(Y1),
    nl,
    write('X2: '),
    write(X2),
    nl,
    write('Y2: '),
    write(Y2),
    nl.

get_move(X1, Y1, X2, Y2):-
    nl,
    write('X1: \n'),
    read(X1),
    nl,
    write('Y1: \n'),
    read(Y1),
    nl,
    write('X2: \n'),
    read(X2),
    nl,
    write('Y2: \n'),
    read(Y2),
    nl.


