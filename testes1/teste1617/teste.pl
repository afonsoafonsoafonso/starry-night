:- dynamic film/4.

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

% Pergunta 1 -> curto(+Movie)
curto(Movie):-
    film(Movie, _, Duration, _),
    Duration < 125.

% Pergunta 2 -> diff(+User1, +User2, -Diff, +Film)
diff(User1, User2, Diff, Film):-
    vote(User1, Votes1),
    vote(User2, Votes2),
    getMovieVote(Film, Votes1, V1),
    getMovieVote(Film, Votes2, V2),
    Diff is abs(V1 - V2),
    !.

getMovieVote(Movie, [Movie-Vote|_], Vote).
getMovieVote(Movie, [_NotMovie-_V|Tail], Vote):-
    getMovieVote(Movie, Tail, Vote).

% Pergunta 3 -> niceGuy(+User)
niceGuy(User):-
    vote(User, Votes),
    niceGuyAux(Votes, 0),
    !.

niceGuyAux(_, 2).
niceGuyAux([_M-V|T], Counter):-
    V >= 8,
    Counter1 is Counter + 1,
    niceGuyAux(T, Counter1).
niceGuyAux([_M-_V|T], Counter):-
    niceGuyAux(T, Counter).

% Pergunta 4 -> elemsComuns(+List1, -Common, +List2)
elemsComuns(List1, Common, List2):-
    elemsComunsAux(List1, List2, [], Common),
    !.

elemsComunsAux([], _, Common, Common).
elemsComunsAux([H|T], List2, Common, Result):-
    member(H, List2),
    elemsComunsAux(T, List2, [H|Common], Result).
elemsComunsAux([_H|T], List2, Common, Result):-
    elemsComunsAux(T, List2, Common, Result).

% Pergunta 5 -> printCategory(+Category)
printCategory(Category):-
    film(Title, Categories, Duration, Rating),
    member(Category, Categories),
    print(Title),
    print(' ('),
    print(Duration),
    print('min , '),
    print(Rating),
    print('/10)'),
    nl,
    fail.
printCategory(_).

% Pergunta 6 -> similarity(+Film1, +Film2, -Similarity)
% Similarity = PercentCommonCat - 3*DurDiff - 5*ScoreDiff
%               -> PercentCommonCat =  CatCommon / CatDiff
similarity(Film1, Film2, Similarity):-
    film(Film1, Cat1, Dur1, Rating1),
    film(Film2, Cat2, Dur2, Rating2),
    elemsComuns(Cat1, ComCats, Cat2),
    length(Cat1, LenCat1),
    length(Cat2, LenCat2),
    length(ComCats, LenCom),
    PercentCommonCat is LenCom / ( LenCat1 + LenCat2 - LenCom) * 100,
    DurDiff is abs(Dur1 - Dur2),
    ScoreDiff is abs(Rating1 - Rating2),
    Similarity is PercentCommonCat - 3*DurDiff - 5*ScoreDiff.

% Pergunta 7 -> mostSimilar(+Film, -Similarity, -Films)
mostSimilar(Film, Similarity, Films):-
    findall(Title, ( film(Title, _, _, _), Title\==Film ), ListOfFilms),
    findMostSimilar(Film, ListOfFilms, 0, [], Similarity, Films),
    !.
    
findMostSimilar(Film, [FilmsH|FilmsT], Max, _Films, MaxFinal, FilmsFinal):-
    similarity(Film, FilmsH, Similarity),
    Similarity > Max,
    Similarity > 10,
    findMostSimilar(Film, FilmsT, Similarity, [FilmsH], MaxFinal, FilmsFinal).

findMostSimilar(Film, [FilmsH|FilmsT], Max, Films, MaxFinal, FilmsFinal):-
    similarity(Film, FilmsH, Similarity),
    Similarity =:= Max,
    findMostSimilar(Film, FilmsT, Max, [FilmsH|Films], MaxFinal, FilmsFinal).

findMostSimilar(Film, [_FilmsH|FilmsT], Max, Films, MaxFinal, FilmsFinal):-
    findMostSimilar(Film, FilmsT, Max, Films, MaxFinal, FilmsFinal).    

findMostSimilar(_, [], Similarity, Films, Similarity, Films).

% Pergunta 8 -> distancia(+User1, -Distancia, +User2)


% Pergunta 9 -> update(+Film)
update(Film):-
    getMovieVotes(Film, [], [], Votes),
    length(Votes, VotesLength),
    list_sum(Votes, Sum),
    NewRat is Sum / VotesLength,
    film(Film, Cat, Dur, Rat),
    retract(film(Film, Cat, Dur, Rat)),
    assert(film(Film, Cat, Dur, NewRat)).

getMovieVotes(Film, CheckedList, VotesList, VotesListFinal):-
    vote(ID, Votes),
    \+ member(ID, CheckedList),
    !,
    (   getMovieVote(Film, Votes, Vote),
        getMovieVotes(Film, [ID|CheckedList], [Vote|VotesList], VotesListFinal)
    ;   getMovieVotes(Film, [ID|CheckedList], VotesList, VotesListFinal)).

getMovieVotes(_, _, VotesList, VotesList).

list_sum(List, Sum):-
    sum_aux(List, 0, Sum).

sum_aux([], Sum, Sum).
sum_aux([H|T], Sum, SumFinal):-
    Sum1 is Sum + H,
    sum_aux(T, Sum1, SumFinal).

% Pergunta 11 -> move/2
move(Pos, Result):-
    moveAux(Pos, [], Result),
    !.

moveAux(Pos, List, Result):-
    move1(Pos, List, Result).

move1(X/Y, List, Result):-
    X1 is X - 2,
    Y1 is Y + 1,
    X1 > 0,
    Y1 < 9,
    move2(X/Y, [X1/Y1|List], Result).
move1(X/Y, List, Result):-move2(X/Y, List, Result).

move2(X/Y, List, Result):-
    X1 is X - 2,
    Y1 is Y - 1,
    X1 > 0,
    Y1 > 0,
    move3(X/Y, [X1/Y1|List], Result).
move2(X/Y, List, Result):-move3(X/Y, List, Result).

move3(X/Y, List, Result):-
    X1 is X + 2,
    Y1 is Y + 1,
    X1 < 9,
    Y1 < 9,
    move4(X/Y, [X1/Y1|List], Result).
move3(X/Y, List, Result):-move4(X/Y, List, Result).

move4(X/Y, List, Result):-
    X1 is X + 2,
    Y1 is Y - 1,
    X1 < 9,
    Y1 > 0,
    move4(X/Y, [X1/Y1|List], Result).
move4(X/Y, List, Result):-move5(X/Y, List, Result).

move5(X/Y, List):-
    X1 is X - 1,
    Y1 is Y - 2,
    X1 > 0,
    Y1 > 0,
    move6(X/Y, [X1/Y1|List], Result).
move5(X/Y, List, Result):-move6(X/Y, List, Result).

move6(X/Y, List, Result):-
    X1 is X + 1,
    Y1 is Y - 2,
    X1 < 9,
    Y1 > 0,
    move7(X/Y, [X1/Y1|List], Result).
move6(X/Y, List, Result):-move7(X/Y, List, Result).

move7(X/Y, List):-
    X1 is X - 1,
    Y1 is Y + 2,
    X1 > 0,
    Y1 < 9,
    move8(X/Y, [X1/Y1|List]).
move7(X/Y, List, Result):-move8(X/Y, List, Result).
    
move8(X/Y, List, Result):-
    X1 is X + 1,
    Y1 is Y + 2,
    X1 < 9,
    Y1 < 9,
    Result = [X/Y|List].
move8(X/Y, List, List).
    

    

    
    




