board_setup(B, P):-
    startBoard(B),
    P is 1.

/*
* Reads coords of chosen piece.
* @param X1, Y1
*/
get_piece_coords(X1, Y1, Board, P):-
    write(' > Select your ship [ X. ; Y. ]:'),
    nl,
    %write(' > X: \n'),
    read(X1),
    %nl,
    %write(' > Y: \n'),
    read(Y1),
    /* Verifies if the piece belong to the home row. */
    get_cell(X1, Y1, Board, C1),
    cell_with_ship(C1),
    home_row_check(X1, Board, P).

get_piece_coords(X1, Y1, Board, P):-
    write(' !!! Invalid cell: you must select a non-empty cell from your home-row.'),
    nl,
    nl,
    get_piece_coords(X1, Y1, Board, P).
    

/*
* Get funtion to list containing all possible destinations with the current piece.
* @param X, Y, P, B, MoveList
*/
get_piece_possible_destinations(X, Y, B, MoveList):-
    findall([X_dest, Y_dest], valid_move(X, Y, X_dest, Y_dest, B), MoveList).


/*
* Reads coords of chosen destination. 
* @param X2, Y2
*/  
get_destination_coords(X2, Y2):-
    nl,
    write(' > Select your destination [ X. ; Y.]:'),
    nl,
    %write(' > X: \n'),
    read(X2),
    %nl,
    %write(' > Y: \n'),
    read(Y2).

/*
* Get funtion for chain move choise.
* @param Choise
*/
get_chain_move(Choise):-
    nl,
    write('Chain Moves:'),
    nl,  
    write('1: Re-program coordinates'),
    nl, 
    write('2: Rocket Boost'),
    nl, 
    read(Choise).

/*
* Reads chain coords for the Re-program coordinates or Rocket Boost. 
* @param X3, Y3
*/
get_chain_move_coords(X3, Y3):-
    nl,
    write('Chain Coords:'),
    nl,
    write('X3:'),
    nl,
    read(X3),
    write('Y3:'),
    nl,
    read(Y3).

/*
* Parses the value in the current board to 'CellValue'
* @param X, Y, Board, CellValue
*/
get_cell(X, Y, Board, CellValue):-
    nth0(X, Board, AuxRow),
    nth0(Y, AuxRow, CellValue).

/*
* Verifies if the coords chosen contains a valid piece.
* @param C
*/
cell_with_ship(C):-
    C>0.
/*
* Verifies if the coords chosen for the destination represents a empty cell.
* @param C
*/
empty_cell(C):-
    C=:=0.

/*
*
*/
replace(0, NewC, [_|T], [NewC|T]).
replace(Y, NewC, [H|T], [H|R]):- 
    Y1 is Y-1, 
    replace(Y1, NewC, T, R).

/*
* Get funtion to the base rows of the board.
* @param B, BRow
*/
get_B_base_row(B, BRow):-
    nth0(7, B, BRow).

get_A_base_row(B, BRow):-
    nth0(0, B, BRow).


/*
*
*/
change_cell(X, Y, Board, NewBoard, CellValue):-
    get_to_row(X, Y, CellValue, Board, NewBoard).


/*
* Get funtions for the board rows excluding the base rows.
* @param X, Y, NewC, [H|T], [H1|R]
*/
get_to_row(X, Y, NewC, [H|T], [H1|R]):-  
    X is 0,
    replace(Y, NewC, H, H1),
    T = R.

get_to_row(X, Y, NewC, [H|T], [H|R]):-  
    X1 is X-1, 
    get_to_row(X1, Y, NewC, T, R).