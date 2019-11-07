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
    end_game_A(B),
    write('PLAYER A WON').

game_loop(B, P):-
    end_game_B(B),
    write('PLAYER B WON').

game_loop(B, P):-
    display_game(B, P),    
    move(B, B1, P),
    ( P =:= 1 -> game_loop(B1, 2) 
    ; game_loop(B1, 1) 
    ).

/*
* Verifies if any ship as landed in any of the two bases.
* @param B
* @param Row, Column, B, C
* @param Row, Column, B, C
*/
end_game_A(B):-
    get_B_base_row(B, BRow),
    any_member([1,2,3], BRow).

end_game_B(B):-
    get_A_base_row(B, BRow),
    any_member([1,2,3], BRow).

%utils
any_member([H|_], L):-
    member(H, L).

any_member([_|T], L):-
    any_member(T, L).

get_B_base_row(B, BRow):-
    nth0(7, B, BRow).

get_A_base_row(B, BRow):-
    nth0(0, B, BRow).

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
move(Board, NewBoard, P):-
    get_move(X1, Y1, X2, Y2),
    get_cell(X1, Y1, Board, C1),
    cell_with_ship(C1),
    home_row_check(X1, Board, P),
    get_cell(X2, Y2, Board, C2),
    dest_cell_in_reach(X1, Y1, X2, Y2, C1),
    move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard).

move(Board, NewBoard, P):-
    write('invalid move'),
    display_game(Board, P),
    move(Board, NewBoard, P).

move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard):-
    cell_with_ship(C2),
    write(C2),
    nl,  
    write('1: Re-program coordinates'),
    nl, 
    write('2: Rocket Boost'),
    nl, 
    read(Choice),
    chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice).

move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard):-
    change_cell(X1, Y1, Board, AuxBoard, C2),
    change_cell(X2, Y2, AuxBoard, NewBoard, C1).

% falta verificar se posição final do reprogram não é nenhuma base
chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice):-
    Choice =:= 1,
    nl,
    write('X3:'),
    nl,
    read(X3),
    write('Y3:'),
    nl,
    read(Y3),
    get_cell(X3, Y3, Board, C3),
    dest_cell_in_reach(X2, Y2, X3, Y3, C1),
    not(cell_with_ship(C3)),
    change_cell(X1, Y1, Board, AuxBoard, C3),
    change_cell(X2, Y2, AuxBoard, AuxBoard2, C1),
    change_cell(X3, Y3, AuxBoard2, NewBoard, C2).

chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice):-
   chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice). 

dest_cell_in_reach(X1, Y1, X2, Y2, C):-
    C =:= abs(X2-X1) + abs(Y2-Y1).

home_row_check(X, B, P):-
    P =:= 1,
    home_row_check_A(X, B, P, 1).

home_row_check(X, B, P):-
    P =:= 2,
    home_row_check_B(X, B, P, 6).

home_row_check_A(X, B, P, I):-
    I<X,
    nth0(I, B, Row),
    not(any_member([1,2,3], Row)),
    I1 is I+1,
    home_row_check_A(X, B, P, I1).

home_row_check_A(X, B, P, I):-
    not(I<X),
    I1 is I-1,
    nth0(I1, B, Row), % futuramente optimizar retirando este calculo repetido(?)
    not(any_member([1,2,3], Row)).

home_row_check_B(X, B, P, I):-
    I>X,
    nth0(I, B, Row),
    not(any_member([1,2,3], Row)),
    I1 is I-1,
    home_row_check_B(X, B, P, I1).

home_row_check_B(X, B, P, I):-
    not(I>X),
    I1 is I+1,
    nth0(I1, B, Row), % futuramente optimizar retirando este calculo repetido(?)
    not(any_member([1,2,3], Row)).


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
cell_with_ship(C):-
    C>0.

% checks if given cell is empty
empty_cell(C):-
    C=:=0.

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

not(Goal):-
    \+ Goal.

