/*
*
*/
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

/*
*
*/
board_setup(B, P):-
    startBoard(B),
    P is 1.

/*
*
*/
start_game:-
    board_setup(B, P),
    game_loop(B, P).

/*
*
*/
game_loop(B, P):-
    display_game(B, P),
    /* end_game(B), ----> NOT WORKING!! WHY?? */
    get_move(X1, Y1, X2, Y2),
    move(X1, Y1, X2, Y2, B, B1),
    Pnext is P+1,
    game_loop(B1, Pnext).

/*
* Verifies if any ship as landed in any of the two bases.
* @param B
* @param Row, Column, B, C
* @param Row, Column, B, C
*/
end_game(B) :-
    Row is 0, Column is 0,
    end_game_a(Row, Column, B, C),
    Row is 7, Column is 0,
    end_game_b(Row, Column, B, C).

end_game_a(Row, Column, B, C) :-
    get_cell(Row, Column, B, C),
    write('Game Over!\nPlayer 1 lost!\n') :- C < 0,
    Row+1 < 6,
    Row_next is Row+1,
    end_game_a(Row_next, Column, B, C).

end_game_b(Row, Column, B, C) :-
    get_cell(Row, Column, B, C),
    write('Game Over!\nPlayer 2 lost!\n') :- C < 0,
    Column+1 < 6,
    (Column_next is Column+1),
    end_game_b(Row, Column_next, B, C).

/*
* Reads coords of chosen piece and destination.
* @param X1, Y1, X2, Y2
*/
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

/*
* Moves the chosen piece to the chosen destination.
* If piece or destination not valid, asks again for the coords.
* @param X1, Y1, X2, Y2, Board, NewBoard
*/
move(X1, Y1, X2, Y2, Board, NewBoard):-
    get_cell(X1, Y1, Board, C1),
    validate_piece(C1),
    get_cell(X2, Y2, Board, C2),
    validate_blank_space(C2),
    change_cell(X1, Y1, Board, AuxBoard, C2),
    change_cell(X2, Y2, AuxBoard, NewBoard, C1).

move(X1, Y1, X2, Y2, Board, NewBoard):-
    get_move(X1, Y1, X2, Y2),
    move(X1, Y1, X2, Y2, Board, NewBoard).

/*
* Parses the value in the current board to 'CellValue'
* @param X, Y, Board, CellValue
*/
get_cell(X, Y, Board, CellValue):-
    nth0(X, Board, AuxRow),
    nth0(Y, AuxRow, CellValue).

/*
* Verifies if the coords chosen contains a valid piece.
* @param C1
*/
validate_piece(C1) :- C1 >= 0.
validate_piece(C1) :- write('ERROR: invalid piece\n').

/*
* Verifies if the coords chosen contains a blank space.
* @param C2
*/
validate_blank_space(C2) :- C2 =:= 0.
validate_blank_space(C2) :- write('ERROR: destination full\n').

/*
* Changes the value of the chosen cell in the current board.
* @param X, Y, Board, NewBoard, CellValue
*/
change_cell(X, Y, Board, NewBoard, CellValue):-
    get_to_row(X, Y, CellValue, Board, NewBoard).

/*
*
*/
replace(0, NewC, [_|T], [NewC|T]).
replace(Y, NewC, [H|T], [H|R]):- 
    Y1 is Y-1, 
    replace(Y1, NewC, T, R).

/*
*
*/
get_to_row(X, Y, NewC, [H|T], [H1|R]):-  
    X is 0,
    replace(Y, NewC, H, H1),
    T = R.

/*
*
*/
get_to_row(X, Y, NewC, [H|T], [H|R]):-  
    X1 is X-1, 
    get_to_row(X1, Y, NewC, T, R).

