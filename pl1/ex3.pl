livro(osMaias).
livro('1984').
livro(thePlague).
livro(warAndPeace).
livro(aFiccao).
livro(aHistoria).

autor(ecaDeQueiroz).
autor(albertCamus).
autor(tolstoy).
autor(afonso).
autor(orwell).

escreveu(autor(ecaDeQueiroz),livro(osMaias)).
escreveu(autor(albertCamus),livro(thePlague)).
escreveu(autor(tolstoy),livro(warAndPeace)).
escreveu(autor(afonso),livro(aFiccao)).
escreveu(autor(afonso),livro(aHistoria)).

nacionalidade(autor(ecaDeQueiroz), portuguesa).
nacionalidade(autor(afonso), portuguesa).
nacionalidade(autor(albertCamus), francesa).
nacionalidade(autor(tolstoy), russa).
nacionalidade(autor(orwell), inglesa).

tipo(livro(osMaias),romance).
tipo(livro('1984'), ficcao).
tipo(livro(thePlage), ficcao).
tipo(livro(warAndPeace), romance).
tipo(livro(aFiccao), ficcao).
tipo(livro(aHistoria), historia).

% Respostas:

% a) escreveu(autor(X), livro(osMaias)).
% b) nacionalidade(autor(X), portuguesa), escreveu(autor(X), livro(Y)), tipo(livro(Y), romance).
% c) escreveu(autor(X),livro(Y)), tipo(livro(Y),ficcao), escreveu(autor(X),livro(Z)), tipo(livro(Z),W), Z\=Y, W\='ficcao'.