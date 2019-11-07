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

start_game:-
    board_setup(B, P),
    game_loop(B, P).

game_loop(B, P):-
    display_game(B, P),    
    get_move(X1, Y1, X2, Y2),
    move(X1, Y1, X2, Y2, B, B1),
    Pnext is P+1,
    game_loop(B1, Pnext).

get_move(X1, Y1, X2, Y2):-
    nl,
    write('X1: \n'),
    read(X1),
    nl,
    write('Y2: \n'),
    read(Y1),
    nl,
    write('X2: \n'),
    read(X2),
    nl,
    write('Y2: \n'),
    read(Y2),
    nl.

move(X1, Y1, X2, Y2, Board, NewBoard):-
    get_cell(X1, Y1, Board, C1),
    cell_with_ship(C1),
    get_cell(X2, Y2, Board, C2),
    empty_cell(C2),
    change_cell(X1, Y1, Board, AuxBoard, C2),
    change_cell(X2, Y2, AuxBoard, NewBoard, C1).

move(_, _, _, _, Board, NewBoard):-
    get_move(X1, Y1, X2, Y2),
    move(X1, Y1, X2, Y2, Board, NewBoard).

get_cell(X, Y, Board, CellValue):-
    nth0(X, Board, AuxRow),
    nth0(Y, AuxRow, CellValue).

/*
* Verifies if the coords choosen contains a valid piece.
*/
cell_with_ship(C):-
    C>0,
    write('cell with ship\n').

% depois pode-se apagar (é só para testing purposes)
cell_with_ship(_):- 
    write('invalid cell\n').

% checks if given cell is empty
empty_cell(C):-
    C=:=0.

change_cell(X, Y, Board, NewBoard, CellValue):-
    get_to_row(X, Y, CellValue, Board, NewBoard).

replace(0, NewC, [_|T], [NewC|T]).
replace(Y, NewC, [H|T], [H|R]):- 
    Y1 is Y-1, 
    replace(Y1, NewC, T, R).

get_to_row(X, Y, NewC, [H|T], [H1|R]):-  
    X is 0,
    replace(Y, NewC, H, H1),
    T = R.

get_to_row(X, Y, NewC, [H|T], [H|R]):-  
    X1 is X-1, 
    get_to_row(X1, Y, NewC, T, R).

