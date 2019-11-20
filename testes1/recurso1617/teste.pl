:- dynamic film/4.
:- dynamic user/3.
:- dynamic vote/2.

%film(Title, Categories, Duration, AvgClassification)
film('Doctor Strange', [action, adventure, fantasy], 115, 7.6).
film('Hacksaw Ridge', [biography, drama, romance], 131, 8.7).
film('Inferno', [action, adventure, crime], 121, 6.4).
film('Arrival', [drama, misteyr, scifi], 116, 8.5).
film('The Accountant', [action, crime, drama], 127, 7.6).
film('The Girl on the Train', [drama, mystery, thriller], 112, 6.7).

%user(Username, YearOfBirth, Country)
user(john, 1992, 'USA').
user(jack, 1989, 'UK').
user(peter, 1983, 'Portugal').
user(harry, 1993, 'USA').
user(richard, 1982, 'USA').

%vote(Username, List_of_Film-Rating)
vote(john, ['Inferno'-7, 'Doctor Strange'-9, 'The Accountant'-6]).
vote(jack, ['Inferno'-8, 'Doctor Strange'-8, 'The Accountant'-7]).
vote(peter, ['The Accountant'-4, 'Hacksaw Ridge'-7, 'The Girl on the Train'-3]).
vote(harry, ['Inferno'-7, 'The Accountant'-6]).
vote(richard, ['Inferno'-10, 'Hacksaw Ridge'-10, 'Arrival'-9]).

% Pergunta 1 -> raro(+Movie)
raro(Movie):-
    film(Movie, _, Dur, _),
    Dur < 60.
raro(Movie):-
    film(Movie, _, Dur, _),
    Dur > 120.

% Pergunta 2 -> happierGuy(+User1, +User2, -HappierGuy)
happierGuy(User1, User2, User1):-
    vote(User1, Votes1),
    vote(User2, Votes2),
    getTotalVotes(Votes1, 0, 0, N1, Total1),
    getTotalVotes(Votes2, 0, 0, N2, Total2),
    Average1 is Total1 / N1,
    Average2 is Total2 / N2,
    Average1 > Average2.

happierGuy(User1, User2, User2):-
    vote(User1, Votes1),
    vote(User2, Votes2),
    getTotalVotes(Votes1, 0, 0, N1, Total1),
    getTotalVotes(Votes2, 0, 0, N2, Total2),
    Average1 is Total1 / N1,
    Average2 is Total2 / N2,
    Average1 < Average2.

getTotalVotes([], Nfinal, Tfinal, Nfinal, Tfinal).
getTotalVotes([_M-V|T], Counter, Total, Nfinal, Tfinal):-
    Counter1 is Counter + 1,
    Total1 is Total + V,
    getTotalVotes(T, Counter1, Total1, Nfinal, Tfinal).

% Pergunta 3 -> likedBetter(+User1, +User2)
likedBetter(User1, User2):-
    vote(User1, Votes1),
    vote(User2, Votes2),
    getMaxVote(Votes1, 0, Max1),
    getMaxVote(Votes2, 0, Max2),
    !,
    Max1 > Max2.

getMaxVote([], Max, Max).
getMaxVote([_M-V|T], Max, MaxFinal):-
    V > Max, 
    getMaxVote(T, V, MaxFinal).
getMaxVote([_M-_V|T], Max, MaxFinal):-
    getMaxVote(T, Max, MaxFinal).

% Pergunta 4 -> recommends(+User, -Movie)
recommends(User, Movie):-
    vote(User, Votes),
    getSeenMovies(Votes, [], SeenMovies),
    %write(SeenMovies).
    recommendsAux(User, SeenMovies, Movie, []).

recommendsAux(User, SeenMovies, Movie, CheckedList):-
    vote(User1, Votes1),
    User \== User1,
    \+ member(User1, CheckedList),
    !,
    getSeenMovies(Votes1, [], SeenMovies1),
    (   getNonMember(SeenMovies1, SeenMovies, Diff),
        Movie = Diff
    ;   recommendsAux(User, SeenMovies, Movie, [User1|CheckedList])
    ).


getSeenMovies([], SeenMovies, SeenMovies).
getSeenMovies([M-_V|T], SeenMovies, Results):-
    getSeenMovies(T, [M|SeenMovies], Results).

getNonMember([H|_T], List2, H):-
    \+ member(H, List2).
getNonMember([_H|T], List2, Diff):-
    getNonMember(T, List2, Diff).

% Pergunta 5 -> invert(+PredicateSymbol, +Arity)
invert(Pred, Arity):-
    invert_preds(Pred, Arity, [], []).
    
generateArgList(0, Arguments, Arguments):-!.
generateArgList(Arity, Arguments, ArgsFinal):-
    Arity1 is Arity - 1,
    generateArgList(Arity1, [_|Arguments], ArgsFinal).

invert_preds(Pred, Arity, Preds, CheckedList):-
    generateArgList(Arity, [], Args),
    G=..[Pred|Args], G,
    \+ member(G, CheckedList),
    !,
    retract(G),
    invert_preds(Pred, Arity, [G|Preds], [G|CheckedList]).

invert_preds(_, _, Preds, _):-
    assert_preds(Preds).

assert_preds([]).
assert_preds([H|T]):-
    assert(H),
    assert_preds(T).

% Pergunta 6 -> onlyOne(+User1, +User2, -OnlyOneList)
onlyOne(User1, User2, OnlyOneList):-
    vote(User1, Votes1),
    vote(User2, Votes2),
    getSeenMovies(Votes1, [], SeenMovies1),
    getSeenMovies(Votes2, [], SeenMovies2),
    findall(NonMember, getNonMember(SeenMovies1, SeenMovies2, NonMember), NonMembers1),
    findall(NonMember, getNonMember(SeenMovies2, SeenMovies1, NonMember), NonMembers2),
    append(NonMembers1, NonMembers2, OnlyOneList).

% Pergunta 7 -> filmVoting/0
filmVoting:-
    findall(Votes, film(Film,_,_,_), Films),
    filmVotingAux(Films).

filmVoting([]).
filmVotingAux([Film|T]):-
    findall(Votes, getVotes(Film, Votes), VotesList),
    assert(filmUserVotes(Film, VotesList)),
    filmVotingAux(T).

getVotes(Film, User-Vote):-
    vote(User, Rating),
    member(Film-Vote, Ratings).
    
    
    
    
    
    
    


    
    


