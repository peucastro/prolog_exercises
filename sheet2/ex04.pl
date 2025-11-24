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
