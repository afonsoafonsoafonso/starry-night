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
game_loop(B, _):-
    game_over(B).

game_loop(B, _):-
    game_over(B).

game_loop(B, P):-
    display_game(B, P), 
    write_turn(P), 
    move(B, B1, P),
    ( P =:= 1 -> game_loop(B1, 2) 
    ; game_loop(B1, 1) 
    ).

game_over(B):-
    end_game_A(B),
    game_over_menu(1).

game_over(B):-
    end_game_B(B),
    game_over_menu(2).

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
    get_cell(X1, Y1, Board, C1),
    display_destination_coords_instructions(1),
    BackTrackingList = [],
    get_destination_coords(0, X1, Y1, X2, Y2, Board, P, C1, BackTrackingList, BackTrackingList_new),
    nl, write(' > BackTrackingList: '), write(BackTrackingList_new), nl,
    get_cell(X2, Y2, Board, C2),
    valid_move(X1, Y1, X2, Y2, C1, C2, P, Board),
    move2(X1, Y1, X2, Y2, C1, C2, P, Board, NewBoard, BackTrackingList_new).

move(Board, NewBoard, P):-
    write('Invalid move!'),
    display_game(Board, P),
    move(Board, NewBoard, P).

/*
*
* @param X1, Y1, X2, Y2, C1, C2, Board, NewBoard
*/
move2(X1, Y1, X2, Y2, C1, C2, P, Board, NewBoard, BackTrackingList):-
    cell_with_ship(C2),
    get_chain_move(Choice),
    chain_move(X1, Y1, X2, Y2, C1, C2, P, Board, NewBoard, Choice, BackTrackingList).

move2(X1, Y1, X2, Y2, C1, C2, _, Board, NewBoard, _):-
    change_cell(X1, Y1, Board, AuxBoard, C2),
    change_cell(X2, Y2, AuxBoard, NewBoard, C1).

/*
*
* @param X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice
*/
% falta verificar se posição final do reprogram não é nenhuma base
/* Choice == 1 --> Repogram Coordinates */
chain_move(X1, Y1, X2, Y2, C1, C2, P, Board, NewBoard, Choice, BackTrackingList):-
    Choice =:= 1,
    display_number_of_moves_allowed(X1, Y1, Board),
    valid_chain_moves(X1, Y1, X2, Y2, P, Board, DestList, 1),
    display_piece_possible_destinations(DestList),
    display_destination_coords_instructions(1),
    get_destination_coords(1, X2, Y2, X3, Y3, Board, P, C2, BackTrackingList, BackTrackingList_new),
    nl, write(' > BackTrackingList: '), write(BackTrackingList_new), nl,
    get_cell(X3, Y3, Board, C3),
    valid_chain_move(X1, Y1, X2, Y2, X3, Y3, C1, C2, C3, P, Board, Choice),
    change_cell(X1, Y1, Board, AuxBoard, C3),
    change_cell(X2, Y2, AuxBoard, AuxBoard2, C1),
    change_cell(X3, Y3, AuxBoard2, NewBoard, C2).

/* Choice == 2 --> Rocket Boost */
chain_move(X1, Y1, X2, Y2, C1, C2, P, Board, NewBoard, Choice, BackTrackingList):-
    Choice =:= 2,
    display_number_of_moves_allowed(X2, Y2, Board),
    valid_chain_moves(X1, Y1, X2, Y2, P, Board, DestList, 2),
    display_piece_possible_destinations(DestList),
    display_destination_coords_instructions(1),
    get_destination_coords(1, X2, Y2, X3, Y3, Board, P, C2, BackTrackingList, BackTrackingList_new),
    nl, write(' > BackTrackingList: '), write(BackTrackingList_new), nl,
    get_cell(X3, Y3, Board, C3),
    valid_chain_move(X1, Y1, X2, Y2, X3, Y3, C1, C2, C3, P, Board, Choice),
    chain_move2(X1, Y1, X2, Y2, X3, Y3, C1, C2, C3, P, Board, NewBoard, Choice, BackTrackingList_new).

chain_move(X1, Y1, X2, Y2, C1, C2, P, Board, NewBoard, Choice, BackTrackingList):-
   chain_move(X1, Y1, X2, Y2, C1, C2, P, Board, NewBoard, Choice, BackTrackingList).

chain_move2(X1, Y1, _, _, X3, Y3, C1, _, _, _, Board, NewBoard, Choice, _):-
    Choice =:= 2,
    X1 =:= X3,
    Y1 =:= Y3,
    change_cell(X1, Y1, Board, NewBoard, C1).   

chain_move2(X1, Y1, _, _, X3, Y3, C1, _, C3, P, Board, NewBoard, Choice, BackTrackingList):-
    Choice =:= 2,
    ( not(cell_with_ship(C3)) ->
      change_cell(X1, Y1, Board, AuxBoard, C3),
      change_cell(X3, Y3, AuxBoard, NewBoard, C1)
    ; move2(X1, Y1, X3, Y3, C1, C3, P, Board, NewBoard, BackTrackingList)  
    ).

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

home_row_check_A(X, B, _, I):-
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

home_row_check_B(X, B, _, I):-
    not(I>X),
    I1 is I+1,
    nth0(I1, B, Row), % futuramente optimizar retirando este calculo repetido(?)
    not(any_member([1,2,3], Row)).

valid_move(X1, Y1, X2, Y2, C1, _, P, B):-
    cell_with_ship(C1),
    home_row_check(X1, B, P),
    dest_cell_in_reach(X1, Y1, X2, Y2, C1),
    not(is_base(X2, P)).

valid_move(X1, Y1, X2, Y2, P, B):-
    get_cell(X1, Y1, B, C1),
    cell_with_ship(C1),
    home_row_check(X1, B, P),
    not(is_base(X2, P)),
    dest_cell_in_reach(X1, Y1, X2, Y2, C1).

/*
*
*/
valid_moves(B, P, MoveList):-
    findall([X1, Y1, X2, Y2], valid_move(X1, Y1, X2, Y2, P, B), MoveList).

/*
*
*/
valid_chain_move(X1, Y1, X2, Y2, X3, Y3, _, B, Choice):-
    Choice =:= 1,
    get_cell(X1, Y1, B, C1),
    get_cell(X3, Y3, B, C3),
    dest_cell_in_reach(X2, Y2, X3, Y3, C1),
    not(cell_with_ship(C3)),
    not(is_base(X3, 1)),
    not(is_base(X3, 2)).

valid_chain_move(_, _, X2, Y2, X3, Y3, P, B, Choice):-
    Choice =:= 2,
    get_cell(X2, Y2, B, C2),
    dest_cell_in_reach(X2, Y2, X3, Y3, C2),
    not(is_base(X3, P)). 

/*
*
*/
valid_chain_move(_, _, X2, Y2, X3, Y3, C1, _, C3, _, _, Choice):-
    Choice =:= 1,
    dest_cell_in_reach(X2, Y2, X3, Y3, C1),
    not(cell_with_ship(C3)),
    not(is_base(X3, 1)),
    not(is_base(X3, 2)).

valid_chain_move(_, _, X2, Y2, X3, Y3, _, C2, _, P, _, Choice):-
    Choice =:= 2,
    dest_cell_in_reach(X2, Y2, X3, Y3, C2),
    not(is_base(X3, P)).

/*
*
*/
valid_chain_moves(X1, Y1, X2, Y2, P, B, MoveList):-
    Choice1 is 1,
    Choice2 is 2,
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, P, B, Choice1), MoveList1),
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, P, B, Choice2), MoveList2),
    append(MoveList1, MoveList2, MoveList).

valid_chain_moves(X1, Y1, X2, Y2, P, B, MoveList, Choice):-
    Choice =:= 1,
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, P, B, Choice), MoveList).

valid_chain_moves(X1, Y1, X2, Y2, P, B, MoveList, Choice):-
    Choice =:= 2,
    findall([X3, Y3], valid_chain_move(X1, Y1, X2, Y2, X3, Y3, P, B, Choice), MoveList).

is_base(X, 1):-
    X=:=0.

is_base(X, 2):-
    X=:=7.


