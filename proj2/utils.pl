:-use_module(library(between)).

/*
* Ficheiro com predicados para diversos usos.
*/

/*
* Obtenção de input do utilizador. Usado para navegar nos menus e para o utilizador construir o seu próprio puzzle.
*/
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

/*
* Obtenção n inputs do utilizador entre Min e Max.
*/
get_n_inputs(Min, Max, N, R):-
    get_n_inputs_aux(Min, Max, N, [], RR),
    reverse(RR, R).

get_n_inputs_aux(_, _, 0, RF, RF).
get_n_inputs_aux(Min, Max, N, R, RF):-
    user_input(Input, Min, Max),
    N1 is N - 1,
    get_n_inputs_aux(Min, Max, N1, [Input|R], RF).

/*
* Predicado para "construir" tabuleiros com valores não instanciados de tamanho personalizado.
*/
buildBoard(N, B) :-
    length(B, N),
    map_list(length_list(N), B).
 
map_list(_, []).
map_list(C, [X|Xs]) :-
    call(C,X),
    map_list(C, Xs).

length_list(N, L) :-
    length(L, N).

/*
* Tabuleiros vazios de tamanho pré-definido usados na visualização dos puzzles pré-definidos.
*/
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