game_loop(B, P, 1):-
    end_game_A(B),
    write('PLAYER A WON').

game_loop(B, P, 1):-
    end_game_B(B),
    write('PLAYER B WON').

game_loop(B, P, 1):-
    display_game(B, P),
    ( P =:= 1 ->
      move(B, B1, P),
      game_loop(B1, 2)
    ; cpu_move(B, B1, P),
      game_loop(B1, 1)
    ).

cpu_move(Board, NewBoard, P):-
    P =:= 2.
