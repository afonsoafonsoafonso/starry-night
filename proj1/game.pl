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

/* 
* Verifies game over.
* Inicializes the display of the board and coordenates the players turns and moves. 
* @param B, P
*/
game_loop(B, P):-
    end_game_A(B),
    write('PLAYER A WON'),
    gameover_menu(1).

game_loop(B, P):-
    end_game_B(B),
    gameover_menu(2).

game_loop(B, P):-
    display_game(B, P), 
    write_turn(P), 
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
* Moves the chosen piece to the chosen destination.
* If piece or destination not valid, asks again for the coords.
* @param X1, Y1, X2, Y2, Board, NewBoard
*/
move(Board, NewBoard, P):-
    get_piece_coords(X1, Y1, Board, P),
    display_number_of_moves_allowed(X1, Y1, Board),
    get_piece_possible_destinations(X1, Y1, P, Board, MoveList),
    display_piece_possible_destinations(MoveList),
    get_destination_coords(X2, Y2),
    get_cell(X1, Y1, Board, C1),
    get_cell(X2, Y2, Board, C2),
    valid_move(X1, Y1, X2, Y2, C1, C2, P, Board),
    move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard).

move(Board, NewBoard, P):-
    write('Invalid move!'),
    display_game(Board, P),
    move(Board, NewBoard, P).

/*
*
* @param X1, Y1, X2, Y2, C1, C2, Board, NewBoard
*/
move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard):-
    cell_with_ship(C2),
    get_chain_move(Choice),
    chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice).

move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard):-
    change_cell(X1, Y1, Board, AuxBoard, C2),
    change_cell(X2, Y2, AuxBoard, NewBoard, C1).

/*
*
* @param X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice
*/
% falta verificar se posição final do reprogram não é nenhuma base
/* Choice == 1 --> Repogram Coordinates */
chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice):-
    Choice =:= 1,
    display_number_of_moves_allowed(X1, Y1, Board),
    valid_chain_moves(X1, Y1, X2, Y2, Board, DestList, 1),
    display_piece_possible_destinations(DestList),
    get_chain_move_coords(X3, Y3),
    get_cell(X3, Y3, Board, C3),
    valid_chain_move(X1, Y1, X2, Y2, X3, Y3, C1, C2, C3, Board, Choice),
    change_cell(X1, Y1, Board, AuxBoard, C3),
    change_cell(X2, Y2, AuxBoard, AuxBoard2, C1),
    change_cell(X3, Y3, AuxBoard2, NewBoard, C2).

/* Choice == 2 --> Rocket Boost */
chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice):-
    Choice =:= 2,
    display_number_of_moves_allowed(X2, Y2, Board),
    valid_chain_moves(X1, Y1, X2, Y2, Board, DestList, 2),
    display_piece_possible_destinations(DestList),
    get_chain_move_coords(X3, Y3),
    get_cell(X3, Y3, Board, C3),
    valid_chain_move(X1, Y1, X2, Y2, X3, Y3, C1, C2, C3, Board, Choice),
    ( not(cell_with_ship(C3)) ->
      change_cell(X1, Y1, Board, AuxBoard, C3),
      change_cell(X3, Y3, AuxBoard, NewBoard, C1)
    ; move2(X1, Y1, X3, Y3, C1, C3, Board, NewBoard)  
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

valid_move(X1, Y1, X2, Y2, C1, C2, P, B):-
    cell_with_ship(C1),
    home_row_check(X1, B, P),
    dest_cell_in_reach(X1, Y1, X2, Y2, C1).

valid_move(X1, Y1, X2, Y2, P, B):-
    get_cell(X1, Y1, B, C1),
    get_cell(X2, Y2, B, C2),
    cell_with_ship(C1),
    home_row_check(X1, B, P),
    dest_cell_in_reach(X1, Y1, X2, Y2, C1).
/*
*
*/
valid_moves(B, P, MoveList):-
    findall([X1, Y1, X2, Y2], valid_move(X1, Y1, X2, Y2, P, B), MoveList).

/*
*
*/
valid_chain_move(X1, Y1, X2, Y2, X3, Y3, B, Choice):-
    Choice =:= 1,
    get_cell(X1, Y1, B, C1),
    get_cell(X3, Y3, B, C3),
    dest_cell_in_reach(X2, Y2, X3, Y3, C1),
    not(cell_with_ship(C3)).

valid_chain_move(X1, Y1, X2, Y2, X3, Y3, B, Choice):-
    Choice =:= 2,
    get_cell(X2, Y2, B, C2),
    get_cell(X3, Y3, B, C3),
    dest_cell_in_reach(X2, Y2, X3, Y3, C2).

/*
*
*/
valid_chain_move(X1, Y1, X2, Y2, X3, Y3, C1, C2, C3, B, Choice):-
    Choice =:= 1,
    dest_cell_in_reach(X2, Y2, X3, Y3, C1),
    not(cell_with_ship(C3)).

valid_chain_move(X1, Y1, X2, Y2, X3, Y3, C1, C2, C3, B, Choice):-
    Choice =:= 2,
    dest_cell_in_reach(X2, Y2, X3, Y3, C2).

/*
*
*/
valid_chain_moves(X1, Y1, X2, Y2, B, MoveList):-
    Choice1 is 1,
    Choice2 is 2,
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, B, Choice1), MoveList1),
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, B, Choice2), MoveList2),
    append(MoveList1, MoveList2, MoveList).

valid_chain_moves(X1, Y1, X2, Y2, B, MoveList, Choice):-
    Choice =:= 1,
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, B, Choice), MoveList).

valid_chain_moves(X1, Y1, X2, Y2, B, MoveList, Choice):-
    Choice =:= 2,
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, B, Choice), MoveList).


