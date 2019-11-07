/*
* Inicial Board game.
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


start_game:-
    board_setup(B, P),
    game_loop(B, P).

/* 
* Verifies game over.
* Inicializes the display of the board and coordenates the players turns and moves. 
* @param B, P
*/
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
*/
end_game_A(B):-
    get_B_base_row(B, BRow),
    any_member([1,2,3], BRow).

end_game_B(B):-
    get_A_base_row(B, BRow),
    any_member([1,2,3], BRow).

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
    /* Gets the desired move and validates the ship. */
    get_move(X1, Y1, X2, Y2),
    get_cell(X1, Y1, Board, C1),
    cell_with_ship(C1),
    /* Verifies if the player chose a ship from his Home row. */
    home_row_check(X1, Board, P),
    /* Validates the destination of the current ship. */
    get_cell(X2, Y2, Board, C2),
    dest_cell_in_reach(X1, Y1, X2, Y2, C1),
    /* Moves the ship. */
    move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard).

move(Board, NewBoard, P):-
    write('invalid move'),
    display_game(Board, P),
    move(Board, NewBoard, P).

/*
*
* @param X1, Y1, X2, Y2, C1, C2, Board, NewBoard
*/
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

/*
*
* @param X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice
*/
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
    Choice =:= 2,
    nl,
    write('X3:'),
    nl,
    read(X3),
    write('Y3:'),
    nl,
    read(Y3),
    get_cell(X3, Y3, Board, C3),
    dest_cell_in_reach(X2, Y2, X3, Y3, C2),
    ( not(cell_with_ship(C3)) ->
      change_cell(X1, Y1, Board, AuxBoard, C3),
      change_cell(X3, Y3, AuxBoard, NewBoard, C1)
    ; chain_move(X1, Y1, X3, Y3, C1, C3, Board, NewBoard, Choice)   
    ).

chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice):-
   chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice). 

/*
* Verifies if the destination cell chosen can be reached with the current ship.
* @param X1, Y1, X2, Y2, C
*/
dest_cell_in_reach(X1, Y1, X2, Y2, C):-
    C =:= abs(X2-X1) + abs(Y2-Y1).

/*
* Funtions that verify if the Base rows are ocupied with a ship.
* If so, the opposite player wins.
*/
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



