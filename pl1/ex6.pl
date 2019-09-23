tweety.
goldie.
molie.
silvester.

passaro(tweety).
peixe(goldie).
minhoca(molie).
gato(silvester).

gosta(passaro(X),minhoca(Y)).
gosta(gato(X),peixe(Y)).
gosta(gato(X),passaro(Y)).

%gosta(X,Y):-amigo(X,Y). faz com que o gato me coma (a)
amigo(gato(silvester),eu).  

come(gato(silvester),Y):-gosta(gato(silvester),Y).
% come(X,Y):-gosta(X,Y). ???

% ? ? ? ? ?  ? ? ? ? ?  ? ? ? ? ? ? ? ? ? ? ? ? 