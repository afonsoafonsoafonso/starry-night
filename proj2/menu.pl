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

show_puzzle_menu(PuzzleNo):-
    nl,nl,nl,write('~~~~~~~~~~~~~~~~~'),nl,nl,nl,
    write('Puzzle #'), write(PuzzleNo), nl,
    puzzle(PuzzleNo, B, N, RestrictRows, RestrictCols),
    ( N =:= 5 -> emptyMidBoard(EmptyB); emptyBigBoard(EmptyB) ),
    display_solution(EmptyB, RestrictRows, RestrictCols),
    nl, nl, write('1: Next Puzzle ; 2: Show Solution ; 3: Main Menu'), nl, nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 3),
    process_puzzle_menu_input(Option, PuzzleNo).

show_solved_puzzle_menu(PuzzleNo):-
    starrynight(B, PuzzleNo),
    nl, write('1: Next Puzzle ; 2: Main Menu'), nl,
    write(' > Choose your option: '), nl,
    user_input(Option, 1, 2),
    process_solved_menu_input(Option, PuzzleNo).

process_puzzle_menu_input(1, PuzzleNo):-
    PuzzleNo1 is PuzzleNo + 1,
    show_puzzle_menu(PuzzleNo1).

process_puzzle_menu_input(2, PuzzleNo):-
    show_solved_puzzle_menu(PuzzleNo1).

process_puzzle_menu_input(3, _):-
        menu.

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
    starrynight(B, Size, RowRestrictions, ColRestrictions).







