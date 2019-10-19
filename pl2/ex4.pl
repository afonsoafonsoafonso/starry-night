fibonacci(0,1). 
fibonacci(1,1). 
fibonacci(N,F):-   
    N > 1, 
    N1 is N - 1, fibonacci(N1,F1), 
    N2 is N - 2, fibonacci(N2,F2), 
    F is F1 + F2.

% bastaria um caso base pois só é preciso N1 e não N1 + N2 como no fibonacci
factorial(0,1).
factorial(1,1).
factorial(N,F):-
    N > 1,
    N1 is N - 1, factorial(N1,F1),
    F is N * F1.

% factorial com recurssividade na cauda de forma a melhorar eficiência
fact(1,F,F).
fact(N,F,Acc):-
    N > 1,
    N1 is N - 1,
    Acc1 is Acc * N,
    fact(N1,F,Acc1).

fact2(N,F):-
    fact(N,F,1).

%TO-DO:
    % - fazer fibonacci com recursivvidade na cauda