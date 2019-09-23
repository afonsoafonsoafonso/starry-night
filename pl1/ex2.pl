pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb, breitling).
team(besenyei, redBull).
team(chambliss, redBull).
team(maclean, medRacing).
team(mangold, cobra).
team(jones, matador).
team(bonhomme, matador).

plane(lamb, mx2).
plane(besenyei, edge540).
plane(chambliss, edge540).
plane(maclean, edge540).
plane(jones, edge540).
plane(bonhomme, edge540).

circuit(istanbul).
circuit(budapest).
circuit(porto).

winner(jones, porto).
winner(mangold, budapest).
winner(mangold, instanbul).

gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

winnerTeam(F,C):-team(P,F),winner(P,C).

% a) winner(X,porto).
% b) winnerTeam(X,porto).
% c) winner(X,Y),winner(X,Z). ?Como garantir que Y!=Z em todas as respostas?
% d) 
