:-use_module(library(clpfd)).

startBoard([
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _]
    ]).

/*
    0: vazio
    1: Sol
    2: Lua
    3: Estrela
*/

starrynight(B):-
    startBoard(B),
    create_board_domains(B),
    check_lines(B).

create_board_domains([]).
create_board_domains([H|T]):-
    domain(H, 0, 3),
    create_board_domains(T).

check_lines([]).
check_lines([H|T]):-
    list_sum(H, S),
    S#=6,
    count(1, H, #=, 1),
    count(2, H, #=, 1),
    count(3, H, #=, 1),
    labeling([], H),
    check_lines(T).

list_sum([H|T], Value):-
    listSumAux([H|T], 0, Value).

listSumAux([], Result, Result).
listSumAux([H|T], Total, Result):-
    Total1 #= Total + H,
    listSumAux(T, Total1, Result).



    
