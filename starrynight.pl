:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-consult('puzzles.pl').
:-consult('display.pl').
:-consult('menu.pl').
:-consult('utils.pl').

/*
    0: vazio
    1: Sol
    2: Lua
    3: Estrela
*/

/*
* Inicia o menu do programa.
*/
start:-
    menu.

/*
* Resolve um dos problemas pre-definidos, numerados de 1-16, especificado em Puzzle. A solução é dada em B.
* Começa por definir os domínios do tabuleiro, garantindo que cada linha tem apenas valores de 0-3. De seguida,
* garante-se que cada linha tem cada um único valor de cada possível (1/sol, 2/lua, 3/estrela) e que as linhas
* respeitam as restrições para as rows.A seguir, verifica as restrições diagonais, garantindo que símbolos
* iguais não se tocam diagonalmente. Por fim, faz as mesmas verificações que fez para as linhas mas numa
* matriz tranposta, ou seja, faz as verificações para as colunas. Depois, estando o labeling feito, faz display.
*/
starrynight(B, Puzzle):-
    puzzle(Puzzle, B, N, RestrictRows, RestrictCols),
    create_board_domains(B),
    check_lines(B, RestrictRows),
    enforce_diagonal_restrictions(B, B, N, 1),
    transpose(B, TB),
    check_lines(TB, RestrictCols),
    append(TB, FTB),
    %write('BEFORE LABELING\n\n'),
    labeling([], FTB),
    %write('AFTER LABELING\n\n'),
    write('  '), display_separator(N),
    display_solution(N, B, RestrictRows, RestrictCols).
    /*
    fd_statistics,
    statistics.
    */

/*
* Predicado com o mesmo propósito do anterior mas usado quando é o utilizador a fazer o seu próprio puzzle.
*/
starrynight(B, N, RestrictRows, RestrictCols):-
    create_board_domains(B),
    check_lines(B, RestrictRows),
    enforce_diagonal_restrictions(B, B, N, 1),
    transpose(B, TB),
    check_lines(TB, RestrictCols),
    append(TB, FTB),
    %write('BEFORE LABELING\n\n'),
    labeling([], FTB),
    %write('AFTER LABELING\n\n'),
    write('  '), display_separator(N),
    display_solution(N, B, RestrictRows, RestrictCols).
    /*
    fd_statistics,
    statistics.
    */

/*
* Menu para quando o puzzle feito pelo utilizador não tem qualquer solução. Os predicados anteriores
* apenas poderão falhar neste cenário, daí estar colocado aqui e não no menu.pl. Já os predicados
* para processar a escolha do user neste menu estão no menu.pl.
*/
starrynight(_, _, _, _):-
    write('No solution was found for your puzzle. Sorry! :('),nl,
    nl, write('1: Make Another ; 2: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 2),
    process_make_your_own_input_option(Option).

/*
* Cria os domínios do tabuleiro, garantindo que os valores da matriz são apenas 0, 1, 2 ou 3
*/
create_board_domains([]).
create_board_domains([H|T]):-
    domain(H, 0, 3),
    create_board_domains(T).

/*
* Garante que apenas existe uma instância de cada figura na respetiva linha, sendo que zeros o número é indiferente
* pois são usados para representar um espaço vazio. Garante também que as restrições laterais são cumpridas.
* De seguida, segue recurssivamente para as seguintes linhas.
*/
check_lines([], []).
check_lines([H|T], [RH|RT]):-
    global_cardinality(H, [1-1, 2-1, 3-1, 0-_]),
    enforce_side_restriction(H, RH),
    check_lines(T, RT).

/*
* Os seguintes predicados forçam o cumprimento das restrições laterais dadas como argumento, podendo ser estas 0, 1, 2 ou 3.
* No caso do 0, não há nenhuma. Quando é um 1, signifca que o sol(1) tem que estar mais perto da estrela(3) na respetiva linha.
* Quando é um 2, é o contrário do referido anteriormente. É calculada a posição dos respetivos elementos na linha e calculada
* a distância para a estrela. COnsoante a restrição, é garantida a maior/igual/menor proximidade das figuras na linha.
*/ 
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

/*
* Predicado recurssivo que, por sua vez, chama o check_row_diagonals para garantir o cumprimento
* das restrições diagonais. Isto é, que nenhuns dois símbolos iguais se podem tocar diagonalmente.
*/
enforce_diagonal_restrictions(_, _, NRows, NRows).
enforce_diagonal_restrictions([H|T], Board, NRows, CurrRow):-
    check_row_diagonals(H, Board, NRows, CurrRow, 1),
    NextRow is CurrRow + 1,
    enforce_diagonal_restrictions(T, Board, NRows, NextRow).

/*
* Para verificar que nenhumas duas células da matriz, diagonalmente vizinhas, têm o mesmo valor diferente
* de zero, ou seja, não têm a mesma figura, basta começar pela primeira linha e verificar apenas a de baixo.
* Para isto há três predicados diferentes para três cenários diferentes: quando se está a verificar a primeira
* célula da linha, a última célula da linha ou as restantes. Nos primeiros dois basta apenas verificar uma diagonal
* (esquerda e direita, respetivamente) enquanto que para o último cenário é preciso verificar a diagonal da esquerda
* e direita.
* Começa-se por calcular a linha inferior, sendo depois obtido as diagonais necessárias. Depois, caso o valor da célula
* atual seja 0, não é preciso nenhuma restrição. Caso não seja, aqui sim é preciso garantir que as diagonais são diferentes.
* Estando estas restrições impostas, é confirmada o seguimento desta regra do jogo.
*/
check_row_diagonals([H|T], Board, NRows, CurrRowN, 1):-
    BelowRowN is CurrRowN + 1,
    RightCol is 2,
    nth1(BelowRowN, Board, BelowRow),
    element(RightCol, BelowRow, RightDiagonal),
    H#=0 #\/ H #\= RightDiagonal,
    %write('First Col of Row Finished'), nl,
    check_row_diagonals(T, Board, NRows, CurrRowN, RightCol).

check_row_diagonals([H|_], Board, NRows, CurrRowN, NRows):-
    CurrColN is NRows,
    BelowRowN is CurrRowN + 1,
    LeftCol is CurrColN - 1,
    nth1(BelowRowN, Board, BelowRow),
    element(LeftCol, BelowRow, LeftDiagonal),
    %write('Last Col of Row Finished'), nl,
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
    %write('Col of Row Finished'), nl,
    check_row_diagonals(T, Board, NRows, CurrRowN, RightCol).
    





    
