game_loop(B, P, 1):-
    end_game_A(B),
    write('PLAYER A WON').

game_loop(B, P, 1):-
    end_game_B(B),
    write('PLAYER B WON').

game_loop(B, P, 1):-
    write('aowidnawod'),
    display_game(B, P),
    ( P =:= 1 ->
      move(B, B1, P),
      game_loop(B1, 2, 1)
    ; cpu_move(B, B1, 2),
      game_loop(B1, 1, 1)
    ).

cpu_move(Board, NewBoard, P):-
    valid_moves(Board, P, MoveList),
    length(MoveList, MoveListLenght),
    random(0, MoveListLenght, RandMove),
    nth0(RandMove, MoveList, Move),
    nl,
    write('CPU MOVE: '),
    print(Move),
    nl,
    unpack_move_list(Move, X1, Y1, X2, Y2),
    get_cell(X1, Y1, Board, C1),
    get_cell(X2, Y2, Board, C2),
    cpu_move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard).

cpu_move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard):-
    cell_with_ship(C2),
    random(1, 3, RandomInt),
    cpu_chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, RandomInt).

cpu_move2(X1, Y1, X2, Y2, C1, C2, Board, NewBoard):-
    change_cell(X1, Y1, Board, AuxBoard, C2),
    change_cell(X2, Y2, AuxBoard, NewBoard, C1).

cpu_chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice):-
    Choice =:= 1,
    write('CPU DID A REPOGRAM COORDINATES YEY'),
    valid_chain_moves(X1, Y1, X2, Y2, Board, MoveList, Choice),
    length(MoveList, MoveListLenght),
    random(0, MoveListLenght, RandMove),
    nth0(RandMove, MoveList, Move),
    nl,
    write('CPU MOVE: '),
    print(Move),
    nl,
    unpack_chain_move_list(Move, X3, Y3),
    get_cell(X3, Y3, Board, C3),
    change_cell(X1, Y1, Board, AuxBoard, C3),
    change_cell(X2, Y2, AuxBoard, AuxBoard2, C1),
    change_cell(X3, Y3, AuxBoard2, NewBoard, C2).

cpu_chain_move(X1, Y1, X2, Y2, C1, C2, Board, NewBoard, Choice):-
    Choice =:= 2,
    write('CPU DID A ROCKET BOOST YEY'),
    valid_chain_moves(X1, Y1, X2, Y2, Board, MoveList, Choice),
    length(MoveList, MoveListLenght),
    random(0, MoveListLenght, RandMove),
    nth0(RandMove, MoveList, Move),
    nl,
    write('CPU MOVE: '),
    print(Move),
    nl,
    unpack_chain_move_list(Move, X3, Y3),
    get_cell(X3, Y3, Board, C3),
    ( not(cell_with_ship(C3)) ->
      change_cell(X1, Y1, Board, AuxBoard, C3),
      change_cell(X3, Y3, AuxBoard, NewBoard, C1)
    ; cpu_move2(X1, Y1, X3, Y3, C1, C3, Board, NewBoard)  
    ).

    


    
