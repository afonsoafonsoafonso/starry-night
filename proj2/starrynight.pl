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

midBoardRestrictionsRows([2, 0, 1, 3, 0]).
midBoardRestrictionsCols([2, 1, 0, 3, 0]).

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
    bigBoard(B),
    bigBoardRestrictionsCols(RestrictCols),
    bigBoardRestrictionsRows(RestrictRows),
    create_board_domains(B),
    check_lines(B, RestrictRows),
    transpose(B, TB),
    check_lines(TB, RestrictCols),
    append(TB, FTB),
    labeling([], FTB).

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




    
