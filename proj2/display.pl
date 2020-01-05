display_solution(N, [], [], RC):-
    write('\n  '),
    display_col_restrictions(RC).

display_solution(N, [R|Rs], [RH|RT], RC):-
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
%display_cell(1):- put_code(9675).
%display_cell(2):- put_code(9679).
%display_cell(3):- put_code(128970).
display_cell(1):- write('1').
display_cell(2):- write('2').
display_cell(3):- write('3').

emptyMidBoard(
    [[0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0]]
    ).

emptyBigBoard(
    [[0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0]]
    ).