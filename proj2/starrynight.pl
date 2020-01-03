:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-consult('puzzles.pl').
:-consult('display.pl').

/*
    0: vazio
    1: Sol
    2: Lua
    3: Estrela
*/

starrynight(B, Puzzle):-
    puzzle(Puzzle, B, N, RestrictRows, RestrictCols),
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
    nth1(BelowRowN, Board, BelowRow),
    element(RightCol, BelowRow, RightDiagonal),
    H#=0 #\/ H #\= RightDiagonal,
    write('First Col of Row Finished'), nl,
    check_row_diagonals(T, Board, NRows, CurrRowN, RightCol).

check_row_diagonals([H|_], Board, NRows, CurrRowN, NRows):-
    CurrColN is NRows,
    BelowRowN is CurrRowN + 1,
    LeftCol is CurrColN - 1,
    nth1(BelowRowN, Board, BelowRow),
    element(LeftCol, BelowRow, LeftDiagonal),
    write('Last Col of Row Finished'), nl,
    H#=0 #\/ H #\= LeftDiagonal.

check_row_diagonals([H|T], Board, NRows, CurrRowN, CurrColN):-
    BelowRowN is CurrRowN + 1,
    LeftCol is CurrColN - 1,
    RightCol is CurrColN + 1,
    nth1(BelowRowN, Board, BelowRow),
    element(LeftCol, BelowRow, LeftDiagonal),
    element(RightCol, BelowRow, RightDiagonal),
    H#=0 #\/ H #\= RightDiagonal,
    H#=0 #\/ H #\= LeftDiagonal,
    write('Col of Row Finished'), nl,
    check_row_diagonals(T, Board, NRows, CurrRowN, RightCol).
    





    
