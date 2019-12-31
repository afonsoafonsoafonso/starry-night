:-use_module(library(clpfd)).
:-use_module(library(lists)).

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

midBoardRestrictionsRows([0, 0, 0, 3, 0]).
midBoardRestrictionsCols([2, 0, 0, 3, 0]).

bigBoard([
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _]
    ], 6).

bigBoardRestrictionsRows([1, 2, 1, 2, 2, 1]).
bigBoardRestrictionsCols([2, 2, 1, 2, 1, 2]).

/*
    0: vazio
    1: Sol
    2: Lua
    3: Estrela
*/

starrynight(B):-
    midBoard(B, N),
    midBoardRestrictionsCols(RestrictCols),
    midBoardRestrictionsRows(RestrictRows),
    create_board_domains(B),
    check_lines(B, RestrictRows),
    enforce_diagonal_restrictions(B, B, N, 1),
    transpose(B, TB),
    check_lines(TB, RestrictCols),
    append(TB, FTB),
    labeling([], FTB),
    display_solution(B, RestrictRows, RestrictCols).

create_board_domains([]).
create_board_domains([H|T]):-
    domain(H, 0, 3),
    create_board_domains(T).

check_lines([], []).
check_lines([H|T], [RH|RT]):-
    sum(H, #=, 6),
    global_cardinality(H, [1-1, 2-1, 3-1, 0-_]),
    enforce_side_restriction(H, RH),
    check_lines(T, RT).

enforce_side_restriction(_, 0).

enforce_side_restriction(L, 1):-
    element(SunPos, L, 1),
    element(MoonPos, L, 2),
    element(StarPos, L, 3),
    DeltaSun #= abs(StarPos - SunPos),
    DeltaMoon #= abs(StarPos - MoonPos),

    DeltaSun #< DeltaMoon.

enforce_side_restriction(L, 2):-
    element(SunPos, L, 1),
    element(MoonPos, L, 2),
    element(StarPos, L, 3),
    DeltaSun #= abs(StarPos - SunPos),
    DeltaMoon #= abs(StarPos - MoonPos),

    DeltaSun #> DeltaMoon.

enforce_side_restriction(L, 3):-
    element(SunPos, L, 1),
    element(MoonPos, L, 2),
    element(StarPos, L, 3),
    DeltaSun #= abs(StarPos - SunPos),
    DeltaMoon #= abs(StarPos - MoonPos),

    DeltaSun #= DeltaMoon.

enforce_diagonal_restrictions(_, _, NRows, NRows).
enforce_diagonal_restrictions([H|T], Board, NRows, CurrRow):-
    check_row_diagonals(H, Board, NRows, CurrRow, 1),
    NextRow is CurrRow + 1,
    enforce_diagonal_restrictions(T, Board, NRows, NextRow).

check_row_diagonals([H|T], Board, NRows, CurrRowN, 1):-
    BelowRowN is CurrRowN + 1,
    RightCol is 2,
    %element(BelowRowN, Board, BelowRow),
    nth1(BelowRowN, Board, BelowRow),
    element(RightCol, BelowRow, RightDiagonal),
    H #\= RightDiagonal,
    write('First Col of Row Finished'), nl,
    check_row_diagonals(T, Board, NRows, CurrRowN, RightCol).

check_row_diagonals([H|T], Board, NRows, CurrRowN, NRows):-
    CurrColN is NRows,
    BelowRowN is CurrRowN + 1,
    LeftCol is CurrColN - 1,
    %element(BelowRowN, Board, BelowRow),
    nth1(BelowRowN, Board, BelowRow),
    element(LeftCol, BelowRow, LeftDiagonal),
    write('Last Col of Row Finished'), nl,
    H #\= LeftDiagonal.
    %check_row_diagonals(T, Board, NRows, CurrRowN, RightCol).

check_row_diagonals([H|T], Board, NRows, CurrRowN, CurrColN):-
    BelowRowN is CurrRowN + 1,
    LeftCol is CurrColN - 1,
    RightCol is CurrColN + 1,
    %element(BelowRowN, Board, BelowRow)
    nth1(BelowRowN, Board, BelowRow),
    element(LeftCol, BelowRow, LeftDiagonal),
    element(RightCol, BelowRow, RightDiagonal),
    H #\= RightDiagonal,
    H #\= LeftDiagonal,
    write('Col of Row Finished'), nl,
    check_row_diagonals(T, Board, NRows, CurrRowN, RightCol).
    
% display functions

display_solution([], [], RC):-
    write('\n  '),
    display_col_restrictions(RC).

display_solution([R|Rs], [RH|RT], RC):-
    nl,
    display_cell(RH),
    write(' | '),
    display_row(R, 0),
    display_solution(Rs, RT, RC).

display_row([], N):-
    write('\n  '),
    display_separator(N).
display_row([H|T], N):-
    N1 is N + 1,
    display_cell(H),
    write(' | '),
    display_row(T, N1).

display_separator(0):-
    write('+').
display_separator(N):-
    write('+---'),
    N1 is N - 1,
    display_separator(N1).

display_col_restrictions([]).
display_col_restrictions([H|T]):-
    write('  '),
    display_cell(H),
    write(' '),
    display_col_restrictions(T).


display_cell(0):- write(' ').
display_cell(1):- write('1').
display_cell(2):- write('2').
display_cell(3):- write('3').
    





    
