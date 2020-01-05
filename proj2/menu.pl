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

show_puzzle_menu(1):-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Puzzle #'), write(1), nl, nl,
    puzzle(1, B, N, RestrictRows, RestrictCols),
    ( N =:= 5 -> emptyMidBoard(EmptyB); emptyBigBoard(EmptyB) ),
    write('  '), display_separator(N), display_solution(EmptyB, RestrictRows, RestrictCols),
    nl, nl, write('1: Next Puzzle ; 2: Show Solution ; 3: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 4),
    process_puzzle_menu_input(Option, 1).

show_puzzle_menu(16):-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Puzzle #'), write(16), nl, nl,
    puzzle(16, B, N, RestrictRows, RestrictCols),
    ( N =:= 5 -> emptyMidBoard(EmptyB); emptyBigBoard(EmptyB) ),
    write('  '), display_separator(N), display_solution(EmptyB, RestrictRows, RestrictCols),
    nl, nl, write('1: Previous Puzzle ; 2: Show Solution ; 3: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 4),
    process_puzzle_menu_input(Option, 16).

show_puzzle_menu(PuzzleNo):-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Puzzle #'), write(PuzzleNo), nl, nl,
    puzzle(PuzzleNo, B, N, RestrictRows, RestrictCols),
    ( N =:= 5 -> emptyMidBoard(EmptyB); emptyBigBoard(EmptyB) ),
    write('  '), display_separator(N), display_solution(EmptyB, RestrictRows, RestrictCols),
    nl, nl, write('1: Next Puzzle ; 2: Previous Puzzle ; 3: Show Solution ; 4: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 4),
    process_puzzle_menu_input(Option, PuzzleNo).

show_solved_puzzle_menu(PuzzleNo):-
    nl, nl, nl, write('Puzzle #'), write(PuzzleNo), write(' - Solution'), nl, nl,
    starrynight(B, PuzzleNo),
    nl, nl, write('1: Next Puzzle ; 2: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 2),
    process_solved_menu_input(Option, PuzzleNo).

show_solved_puzzle_menu(16):-
    nl, nl, nl, write('Puzzle #'), write(16), write(' - Solution'), nl, nl,
    starrynight(B, 16),
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

process_solved_menu_input(2, PuzzleNo):-
    menu.

make_your_own_menu:-
    write(' > Board size: '), nl,
    user_input(Size, 1, 10),
    nl, nl,
    write(' > Input row restrictions: '), nl,
    get_n_inputs(0, 3, Size, RowRestrictions),
    write(' > Input col restrictions: '), nl,
    get_n_inputs(0, 3, Size, ColRestrictions),
    nl, nl, write('Your puzzle:'), nl,
    buildBoard(Size, B),
    !,
    starrynight(B, Size, RowRestrictions, ColRestrictions).







