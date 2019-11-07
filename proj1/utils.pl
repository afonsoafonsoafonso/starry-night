any_member([H|_], L):-
    member(H, L).

any_member([_|T], L):-
    any_member(T, L).

not(Goal):-
    \+ Goal.