%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

% Pergunta 1 -> madeItThrough(+Participant)
madeItThrough(Participant):-
    performance(Participant, Performance),
    madeItThroughAux(Performance),
    !.

madeItThroughAux([]):-fail.
madeItThroughAux([H|_T]):-
    H =:= 120.
madeItThroughAux([_H|T]):-
    madeItThroughAux(T). 

% Pergunta 2 -> juriTimes(+Participants, +JuriMember, -Times, -Total)
juriTimes(Participants, JuriMember, Times, Total):-
    juriTimesAux(Participants, JuriMember, [], TimesReversed, 0, Total),
    reverse(TimesReversed, Times).

juriTimesAux([], _JuriMember, Times, Times, Total, Total).
juriTimesAux([ParticipantsH|ParticipantsT], JuriMember, Times, TimesFinal, Total, TotalFinal):-
    performance(ParticipantsH, Performance),
    Index is JuriMember - 1,
    getByIndex(Performance, Index, Time),
    Total1 is Total + Time,
    juriTimesAux(ParticipantsT, JuriMember, [Time|Times], TimesFinal, Total1, TotalFinal).

getByIndex([H|_T], 0, H):-!.
getByIndex([_H|T], Index, Value):-
    Index1 is Index - 1,
    getByIndex(T, Index1, Value).

% Pergunta 3 -> patientJuri(+JuriMember)
patientJuri(JuriMember):-
    patientJuriAux(JuriMember, [], 0),
    !.

patientJuriAux(_, _, 2).

patientJuriAux(JuriMember, PerformanceList, Counter):-
    performance(ID, Performance),
    \+ member(ID, PerformanceList),
    !,
    Index is JuriMember - 1,
    getByIndex(Performance, Index, Time),
    (   Time =:= 120,
        Counter1 is Counter + 1
    ;   Counter1 is Counter),
    patientJuriAux(JuriMember, [ID|PerformanceList], Counter1).

% Pergunta 4 -> bestParticipant(+P1, +P2, -P)
bestParticipant(P1, P2, P):-
    performance(P1, P1Times),
    performance(P2, P2Times),
    listSum(P1Times, P1Total),
    listSum(P2Times, P2Total),
    getBest(P1Total, P2Total, P1, P2, P).

getBest(T1, T2, P1, _P2, P1):-
    T1 > T2.

getBest(T1, T2, _P1, P2, P2):-
    T1 < T2.

listSum([H|T], Value):-
    listSumAux([H|T], 0, Value).

listSumAux([], Result, Result).
listSumAux([H|T], Total, Result):-
    Total1 is Total + H,
    listSumAux(T, Total1, Result).

% Pergunta 5 -> allPerfs
allPerfs:-
    participant(ID, _, Act),
    performance(ID, Times),
    write(ID),
    write(':'),
    write(Act),
    write(':'),
    write(Times),
    nl,
    fail.

allPerfs.

% Pergunta 6 -> nSuccessfulParticipants(-T)
nSuccessfulParticipants(T):-
    nSuccessfulParticipantsAux([], 0, T),
    !.

nSuccessfulParticipantsAux(CheckedList, Counter, Result):-
    performance(ID, Times),
    \+ member(ID, CheckedList),
    !,
    (   noButtonPress(Times),
        Counter1 is Counter + 1
    ;   Counter1 is Counter),
    nSuccessfulParticipantsAux([ID|CheckedList], Counter1, Result).

nSuccessfulParticipantsAux(_, Result, Result).
    
noButtonPress([]):- !.
noButtonPress([120|T]):- noButtonPress(T).
noButtonPress([_H|_T]):- fail.

% Pergunta 7 -> juriFans(-juriFansList)
juriFans(JuriFansList):-
    juriFansAux([], [], JuriFansList).

juriFansAux(CheckedList, JuriFansList, Result):-
    performance(ID, Times),
    \+ member(ID, CheckedList),
    !,
    getJuriFans(Times, JuriFans),
    juriFansAux([ID|CheckedList], [ID-JuriFans|JuriFansList], Result).

juriFansAux(_, ReversedResult, Result):-
    reverse(ReversedResult, Result).

getJuriFans(Times, Juris):-
    getJuriFansAux(Times, 1, [], Juris1),
    reverse(Juris1, Juris),
    !.
    
getJuriFansAux([], _, Result, Result).

getJuriFansAux([120|T], CurrJuri, Juris, Result):-
    CurrJuri1 is CurrJuri + 1,
    getJuriFansAux(T, CurrJuri1, [CurrJuri|Juris], Result).

getJuriFansAux([_H|T], CurrJuri, Juris, Result):-
    CurrJuri1 is CurrJuri + 1,
    getJuriFansAux(T, CurrJuri1, Juris, Result).

% Pergunta 8 -> nextPhase(+N, -Participants)
:- use_module(library(lists)).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).
%-------------------------------

nextPhase(N, Participants):-
    findall([TT-ID-Perf], eligibleOutcome(ID, Perf, TT), Eligibles),
    filterBest(Eligibles, N, Participants1),
    reverse(Participants1, Participants),
    !.
    
filterBest(Eligibles, N, Result):-
    sort(Eligibles, Eligibles1),
    reverse(Eligibles1, SortedEligibles),
    filterBestAux(SortedEligibles, 0, N, [], Result).

filterBestAux([], _, _, _):-fail.
filterBestAux(_, N, N, Result, Result).
filterBestAux([H|T], Counter, N, Result, ResultFinal):-
    Counter1 is Counter + 1,
    filterBestAux(T, Counter1, N, [H|Result], ResultFinal).

% Pergunta 9
predX(Q,[R|Rs],[P|Ps]) :-
    participant(R,I,P), I=<Q, !,
    predX(Q,Rs,Ps).
predX(Q,[R|Rs],Ps) :-
    participant(R,I,_), I>Q,
    predX(Q,Rs,Ps).
predX(_,[],[]).

% R: Guarda no terceiro argumento as actuações dos participantes
%    no segundo argumento que têm menos que a idade dada no primeiro argumento
%    O Cut é verde pois não altera o resultado final, servindo apenas para
%    evitar o cálculo de alternativas desnecessariamente.

% Pergunta 10
impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

% R: Este predicado esta se a lista L cumpre o comprimento necessário
%    de forma a cumprir o exposto no enunciado. Esta lista terá que começar
%    e acabar no mesmo número tendo um número de elementos iguais a este número
%    entre eles.

% Pergunta 11 -> langford(+N,-L)
langford(N, L):-
    S is N * 2,
    length(L, S),
    langfordAux(N, L).

langfordAux(0, _).
langfordAux(N, L):-
    impoe(N, L),
    N1 is N - 1,
    langfordAux(N1, L).


    




    