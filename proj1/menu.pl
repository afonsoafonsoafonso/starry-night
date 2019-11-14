menu:-
    display_menu,
    write(' > Choose your option: '),
    nl,
    read(Option),
    process_menu_input(Option).

process_menu_input(1):-
    start_game(1).

process_menu_input(2):-
    start_game(2).

process_menu_input(3):-
    write('NOT IMPLEMENTED YET').

process_menu_input(4).

start_game(Option):-
    Option =:= 1,
    board_setup(B, P),
    game_loop(B, P).

start_game(Option):-
    Option =:= 2,
    board_setup(B, P),
    game_loop(B, P, 1).



display_menu:-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
   % write('|            ██╗  ██╗███████╗██████╗  ██████╗        ██████╗            |'),nl,
   % write('|            ╚██╗██╔╝██╔════╝██╔══██╗██╔═══██╗      ██╔════╝            |'),nl,
   % write('|             ╚███╔╝ █████╗  ██████╔╝██║   ██║█████╗██║  ███╗           |'),nl,
   % write('|             ██╔██╗ ██╔══╝  ██╔══██╗██║   ██║╚════╝██║   ██║           |'),nl,
   % write('|            ██╔╝ ██╗███████╗██║  ██║╚██████╔╝      ╚██████╔╝           |'),nl,
   % write('|             ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝        ╚═════╝           |'),nl,
    write('|       /\\                                                              |'),nl,
    write('|      |==|                                                             |'),nl,
    write('|      |  |                1. Player vs Player                          |'),nl,
    write('|     /____\\                                                            |'),nl,
    write('|     |    |               2. Player vs CPU                             |'),nl,
    write('|     |    |                                                            |'),nl,
	write('|    /| |  |\\              3. CPU vs CPU                                |'),nl,
    write('|   / | |  | \\                                                          |'),nl,
    write('|  /__|_|__|__\\            4. Exit                                      |'),nl,
    write('|     /_\\/_\\                                                            |'),nl,
    write('|     ######                                                            |'),nl,
    write(' ____########___________________________________________________________ '),nl,nl,nl.                         



