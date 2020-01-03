:-use_module(library(between)).

user_input(Input, Min, Max):-
    catch(read(Input),_Err,fail),
    integer(Input),
    between(Min, Max, Input).
  
user_input(Input, Min, Max):-
    nl,
    write('Invalid Input. Retry:'),
    nl,
    nl,
    user_input(Input, Min, Max).

get_n_inputs(Min, Max, N, R):-
    get_n_inputs_aux(Min, Max, N, [], R).

get_n_inputs_aux(_, _, 0, RF, RF).
get_n_inputs_aux(Min, Max, N, R, RF):-
    user_input(Input, Min, Max),
    N1 is N - 1,
    get_n_inputs_aux(Min, Max, N1, [Input|R], RF).
/*
get_n_inputs(_, _, 0, R).
get_n_inputs(Min, Max, N, [Input|R]):-
    user_input(Input, Min, Max),
    N1 is N - 1,
    get_n_inputs(Min, Max, N1, R).
*/