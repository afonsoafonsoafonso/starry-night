smallBoard([
    [_, _, _, _],
    [_, _, _, _],
    [_, _, _, _],
    [_, _, _, _]
    ], 4).

midBoard([
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _]
    ], 5).

bigBoard([
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _]
    ], 6).

puzzle(1, Board, Size, RowRestrictions, ColRestrictions):-
    midBoard(Board, Size),
    append([], [0, 0, 0, 1, 0], RowRestrictions),
    append([], [1, 3, 0, 0, 0], ColRestrictions).

puzzle(2, Board, Size, RowRestrictions, ColRestrictions):-
    midBoard(Board, Size),
    append([], [0, 0, 0, 2, 0], RowRestrictions),
    append([], [0, 3, 3, 0, 0], ColRestrictions).

puzzle(3, Board, Size, RowRestrictions, ColRestrictions):-
    midBoard(Board, Size),
    append([], [0, 0, 0, 3, 0], RowRestrictions),
    append([], [0, 3, 2, 0, 0], ColRestrictions).

puzzle(4, Board, Size, RowRestrictions, ColRestrictions):-
    midBoard(Board, Size),
    append([], [0, 0, 0, 1, 0], RowRestrictions),
    append([], [0, 3, 2, 0, 0], ColRestrictions).

puzzle(5, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [3, 0, 3, 0, 0, 0], RowRestrictions),
    append([], [0, 3, 3, 0, 2, 0], ColRestrictions).

puzzle(6, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [0, 0, 3, 0, 3, 3], RowRestrictions),
    append([], [1, 0, 0, 0, 3, 0], ColRestrictions).

puzzle(7, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [0, 3, 2, 3, 0, 0], RowRestrictions),
    append([], [0, 0, 3, 1, 1, 0], ColRestrictions).

puzzle(8, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [3, 0, 0, 0, 1, 0], RowRestrictions),
    append([], [0, 2, 1, 0, 3, 3], ColRestrictions).

puzzle(9, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [1, 1, 2, 0, 0, 3], RowRestrictions),
    append([], [0, 0, 1, 0, 1, 3], ColRestrictions).

puzzle(10, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [0, 0, 2, 0, 2, 1], RowRestrictions),
    append([], [3, 3, 1, 0, 0, 0], ColRestrictions).

puzzle(11, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [0, 1, 1, 1, 0, 0], RowRestrictions),
    append([], [3, 1, 0, 0, 3, 1], ColRestrictions).

puzzle(12, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [1, 3, 2, 0, 2, 0], RowRestrictions),
    append([], [2, 3, 1, 0, 0, 0], ColRestrictions).

puzzle(13, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [2, 1, 2, 1, 2, 0], RowRestrictions),
    append([], [0, 2, 0, 3, 1, 1], ColRestrictions).

puzzle(14, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [3, 1, 0, 2, 2, 0], RowRestrictions),
    append([], [2, 2, 1, 2, 0, 2], ColRestrictions).

puzzle(15, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [1, 1, 2, 1, 1, 1], RowRestrictions),
    append([], [2, 1, 1, 2, 1, 1], ColRestrictions).

puzzle(16, Board, Size, RowRestrictions, ColRestrictions):-
    bigBoard(Board, Size),
    append([], [1, 2, 1, 2, 2, 1], RowRestrictions),
    append([], [2, 2, 1, 2, 1, 2], ColRestrictions).

makeBoard(N, B):-
    makeBoardAux([], B, N, N).

makeBoardAux(B, B, N, 0).
makeBoardAux(B, FB, N, C):-
    C1 is C - 1,
    buildList(N, Row),
    makeBoardAux([Row|B], FB, N, C1).
 
buildBoard(N, B) :-
    length(B, N),
    map_list(length_list(N), B).
 
map_list(_, []).
map_list(C, [X|Xs]) :-
    call(C,X),
    map_list(C, Xs).

length_list(N, L) :-
    length(L, N).
    