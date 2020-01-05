/*
* Predicado que desenha o menu principal.
*/
display_menu:-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                    *             *                                    |'),nl,
    write('|      *                            *          *        *          *    |'),nl,
    write('|        _____ _                          _   _ _       _     _         |'),nl,
    write('|       / ____| |         *              | \\ | (_)  *  | |   | |    *   |'),nl,
    write('|      | (___ | |_ __ _ _ __ _ __ _   _  |  \\| |_  __ _| |__ | |_       |'),nl,
    write('|       \\___ \\| __/ _\` | \'__| \'__| | | | | . \` | |/ _\` | \'_ \\| __|      |'),nl,
    write('|       ____) | || (_| | |  | |  | |_| | | |\\  | | (_| | | | | |_       |'),nl,
    write('|      |_____/ \\__\\__,_|_|  |_|   \\__, | |_| \\_|_|\\__, |_| |_|\\__|      |'),nl,
    write('|   *                              __/ |           __/ |                |'),nl,
    write('|                      *          |___/      *    |___/    *            |'),nl,
    write('|                                                                  *    |'),nl,
    write('|           *                                                           |'),nl,
    write('|                          1. Choose Puzzle      *           *          |'),nl,
    write('|                  *                                                    |'),nl,
	write('|       *                  2. Make Your Own                             |'),nl,
    write('|                                                                 *     |'),nl,
    write('|                              3. Exit              *                   |'),nl,
    write('|                   *                                                   |'),nl,
    write('|     *                             *           *                   *   |'),nl,
    write('|_______________________________________________________________________|'),nl,nl,nl.

/*
* Menu principal. Desenha a interface e pede input ao utilizador de forma a ele poder
* navegar para os diferentes menus.
*/
menu:-
    display_menu,
    write(' > Choose your option: '),
    nl,
    user_input(Option, 1, 3),
    process_menu_input(Option).

process_menu_input(1):-
    show_puzzle_menu(1).

process_menu_input(2):-
    make_your_own_menu.

process_menu_input(3).

/*
* Predicado de display do menu do puzzle #1. Tem um predicado exclusivo devido à opção de "Previous Puzzle",
* que não deve estar aqui presente.
*/
show_puzzle_menu(1):-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Puzzle #'), write(1), nl, nl,
    puzzle(1, _B, N, RestrictRows, RestrictCols),
    ( N =:= 5 -> emptyMidBoard(EmptyB); emptyBigBoard(EmptyB) ),
    write('  '), display_separator(N), display_solution(N, EmptyB, RestrictRows, RestrictCols),
    nl, nl, write('1: Next Puzzle ; 2: Show Solution ; 3: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 4),
    process_puzzle_menu_input(Option, 1).

/*
* Predicado de display do menu do puzzle #16. Tem um predicado exclusivo devido à opção de "Next Puzzle",
* que não deve estar aqui presente.
*/
show_puzzle_menu(16):-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Puzzle #'), write(16), nl, nl,
    puzzle(16, _B, N, RestrictRows, RestrictCols),
    ( N =:= 5 -> emptyMidBoard(EmptyB); emptyBigBoard(EmptyB) ),
    write('  '), display_separator(N), display_solution(N, EmptyB, RestrictRows, RestrictCols),
    nl, nl, write('1: Previous Puzzle ; 2: Show Solution ; 3: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 4),
    process_puzzle_menu_input(Option, 16).

/*
* Predicado de display do menu do puzzle dado em PuzzloeNo.
*/
show_puzzle_menu(PuzzleNo):-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Puzzle #'), write(PuzzleNo), nl, nl,
    puzzle(PuzzleNo, _B, N, RestrictRows, RestrictCols),
    ( N =:= 5 -> emptyMidBoard(EmptyB); emptyBigBoard(EmptyB) ),
    write('  '), display_separator(N), display_solution(N, EmptyB, RestrictRows, RestrictCols),
    nl, nl, write('1: Next Puzzle ; 2: Previous Puzzle ; 3: Show Solution ; 4: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 4),
    process_puzzle_menu_input(Option, PuzzleNo).

/*
* Predicado de display do menu do puzzle mas depois do user ter pedido a solução do mesmo,
* mostrando-o então resolvido.
*/
show_solved_puzzle_menu(PuzzleNo):-
    nl, nl, nl, write('Puzzle #'), write(PuzzleNo), write(' - Solution'), nl, nl,
    starrynight(_B, PuzzleNo),
    nl, nl, write('1: Next Puzzle ; 2: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 2),
    process_solved_menu_input(Option, PuzzleNo).

/*
* Predicado de display do menu do puzzle mas depois do user ter pedido a solução do mesmo,
* mostrando-o então resolvido. Tem um predicado exclusivo devido à opção de "Next Puzzle",
* que não deve estar aqui presente.
*/
show_solved_puzzle_menu(16):-
    nl, nl, nl, write('Puzzle #'), write(16), write(' - Solution'), nl, nl,
    starrynight(_B, 16),
    nl, nl, write('1: Previous Puzzle ; 2: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 2),
    process_solved_menu_input(Option, 16).

process_puzzle_menu_input(1, 1):-
    show_puzzle_menu(2).

process_puzzle_menu_input(2, 1):-
    show_solved_puzzle_menu(1).

process_puzzle_menu_input(3, 1):-
    menu.

process_puzzle_menu_input(1, 16):-
    show_puzzle_menu(15).

process_puzzle_menu_input(2, 16):-
    show_solved_puzzle_menu(16).

process_puzzle_menu_input(3, 16):-
    menu.  

process_puzzle_menu_input(1, PuzzleNo):-
    PuzzleNo1 is PuzzleNo + 1,
    show_puzzle_menu(PuzzleNo1).

process_puzzle_menu_input(2, PuzzleNo):-
    PuzzleNo1 is PuzzleNo - 1,
    show_puzzle_menu(PuzzleNo1).

process_puzzle_menu_input(3, PuzzleNo):-
    show_solved_puzzle_menu(PuzzleNo).

process_puzzle_menu_input(4, _PuzzleNo):-
    menu.

process_solved_menu_input(1, 16):-
    show_puzzle_menu(15).

process_solved_menu_input(1, PuzzleNo):-
    PuzzleNo1 is PuzzleNo + 1,
    show_puzzle_menu(PuzzleNo1).

process_solved_menu_input(2, _PuzzleNo):-
    menu.

/*
* Menu de criação de puzzles pelo user. Aqui ele pode escolher o tamanho do tabuleiro e as restrições
* para as colunas e linhas. Limite de 5-15 no tamanho do tabuleiro pois, para valores inferior a 5, os possíveis puzzles
* são pouquíssimos. Enquanto que para valores acima de 15 o tempo de cálculo é demasiado grande.
*/
make_your_own_menu:-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Make your own puzzle!'),
    nl, nl,write(' > Board size (min: 5, max: 15): '), nl,
    user_input(Size, 5, 15),
    nl,
    write(' > Input row restrictions: '), nl,
    get_n_inputs(0, 3, Size, RowRestrictions),
    nl, nl, write(' > Input col restrictions: '), nl,
    get_n_inputs(0, 3, Size, ColRestrictions),
    nl, nl, write('Your puzzle:'), nl, nl,
    buildBoard(Size, B),
    starrynight(B, Size, RowRestrictions, ColRestrictions),
    nl, nl, write('1: Make Another ; 2: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 2),
    process_make_your_own_input_option(Option).

/*
* Processar input do utilizador no respetivo menu.
*/
process_make_your_own_input_option(1):-
    make_your_own_menu.

/*
* Processar input do utilizador no respetivo menu.
*/
process_make_your_own_input_option(2):-
    menu.







