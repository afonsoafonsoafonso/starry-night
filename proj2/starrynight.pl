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

midBoardRestrictionsRows([3, 0, 2, 0, 1]).
midBoardRestrictionsCols([0, 0, 0, 0, 0]).

bigBoard([
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _],
    [_, _, _, _, _, _]
    ]).

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
    append(B, FB),
    labeling([], FB).

create_board_domains([]).
create_board_domains([H|T]):-
    domain(H, 0, 3),
    create_board_domains(T).

check_lines([], []).
check_lines([H|T], [RH|RT]):-
    list_sum(H, S),
    S#=6,
    count(1, H, #=, 1),
    count(2, H, #=, 1),
    count(3, H, #=, 1),
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
    
list_sum([H|T], Value):-
    listSumAux([H|T], 0, Value).

listSumAux([], Result, Result).
listSumAux([H|T], Total, Result):-
    Total1 #= Total + H,
    listSumAux(T, Total1, Result).




    
