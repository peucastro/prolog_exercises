% a) Implement the factorial(+N, -F) predicate, which calculates the factorial of a number N.

factorial(0, 1).
factorial(N, F) :- N > 0,
                   N1 is N - 1,
                   factorial(N1, F1),
                   F is F1 * N.

% b) Implement sum_rec(+N, -Sum) as a recursive predicate to determine the sum of all numbers from one to N.

sum_rec(1, 1).
sum_rec(N, Sum) :- N > 1,
                   N1 is N - 1,
                   sum_rec(N1, Sum1),
                   Sum is N + Sum1.

% c) Implement the pow_rec(+X, +Y, -P) predicate, which recursively determines the result of raising X to the power of Y.

pow_rec(_, 0, 1).
pow_rec(X, Y, P) :- Y > 0,
                    Y1 is Y - 1,
                    pow_rec(X, Y1, P1),
                    P is P1 * X.

% d) Implement the square_rec(+N, -S) predicate, which recursively determines que square of a number N (ie, without using multiplications).
% Suggestion: you may need to use an auxiliary predicate with additional arguments.

aux_s(_, 0, 0).
aux_s(X, C, S) :- C > 0,
                C1 is C - 1,
                aux(X, C1, S1),
                S is S1 + X.

square_rec(N, S) :- aux_s(N, N, S).

% e) Implement the fibonacci(+N, -F) predicate, which determines the Fibonacci number of order N.

fib(0, 0).
fib(1, 1).
fib(2, 1).
fib(N, S) :- N > 2,
             N1 is N - 1,
             N2 is N - 2,
             fib(N1, S1),
             fib(N2, S2),
             S is S1 + S2.

% f) Implement collatz(+N, -S), which receives a positive integer number N and determines the number of steps necessary to reach 1 following the operations set forth by this sequence: if N is even, in the next step it will take the value N/2; if N is odd, in the next step it will take the value 3N+1.

collatz(1, 0).
collatz(N, S) :- N > 1,
                 0 is N mod 2,
                 N1 is N // 2,
                 collatz(N1, S1),
                 S is S1 + 1.
collatz(N, S) :- N > 1,
                 1 is N mod 2,
                 N1 is 3 * N + 1,
                 collatz(N1, S1),
                 S is S1 + 1.

% g) Implement the is_prime(+X) predicate, which determines whether X is a prime number. Suggestion: a number is prime if it is divisible only by itself and one.

aux_p(N, I) :- I * I > N.
aux_p(N, I) :- I > 0,
               R is N mod I,
               R \= 0,
               I1 is I + 1,
               aux_p(N, I1).

is_prime(2).
is_prime(X) :- X > 1,
               aux_p(X, 2).
               

