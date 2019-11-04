:- consult('display.pl').
:- consult('game.pl').
:- use_module(library(lists)).

play(1).
exit(2).

menu:-
    menu('Xero-G', [1 : 'Play', 2 : 'Exit'], Choice),
    play(Choice),
    nl,
    start_game().

menu:-
    menu('Xero-G', [1 : 'Play', 2 : 'Exit'], Choice),
    exit(Choice),
    break.
    


