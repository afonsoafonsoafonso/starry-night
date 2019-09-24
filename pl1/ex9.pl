aluno(joao, paradigmas). 
aluno(maria, paradigmas).  
aluno(joel, lab2). 
aluno(joel, estruturas).  
frequenta(joao, feup). 
frequenta(maria, feup).  
frequenta(joel, ist). 
professor(carlos, paradigmas). 
professor(ana_paula, estruturas).  
professor(pedro, lab2). 
funcionario(pedro, ist). 
funcionario(ana_paula, feup).  
funcionario(carlos, feup).

% a):
alunos(X,Y):-aluno(Y,Z),professor(X,Z).

% b):
pessoas(X,Z):-frequenta(X,Z).
pessoas(X,Z):-funcionario(X,Z).

% c):
colega(X,Y):-frequenta(X,Z),frequenta(Y,Z).
colega(PROF1,PROF2):-professor(PROF1,CAD1), professor(PROF2,CAD2), funcionario(PROF1,FAC), funcionario(PROF2,FAC).