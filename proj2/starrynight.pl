:-use_module(library(clpfd)).
:-use_module(library(lists)).

smallBoard([
    [_, _, _, _],
    [_, _, _, _],
    [_, _, _, _],
    [_, _, _, _]
    ]).

midBoard([
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _]
    ]).

midBoardRestrictionsRows([0, 0, 0, 3, 0]).
midBoardRestrictionsCols([2, 0, 0, 3, 0]).

bigBoard([
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _]
    ]).

bigBoardRestrictionsRows([1, 2, 1, 2, 2, 1]).
bigBoardRestrictionsCols([2, 2, 1, 2, 1, 2]).

/*
    0: vazio
    1: Sol
    2: Lua
    3: Estrela
*/

starrynight(B):-
    midBoard(B),
    midBoardRestrictionsCols(RestrictCols),
    midBoardRestrictionsRows(RestrictRows),
    create_board_domains(B),
    check_lines(B, RestrictRows),
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
    





    
