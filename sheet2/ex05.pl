/* a) Implement the factorial(+N, -F) predicate, which calculates the factorial of a number N. */

factorial_aux(0, Acc, Acc).
factorial_aux(N, Acc, F) :- N > 0,
                            Acc1 is Acc * N,
                            N1 is N - 1,
                            factorial_aux(N1, Acc1, F).

factorial(N, F) :- factorial_aux(N, 1, F).

/* b) Implement sum_rec(+N, -Sum) as a recursive predicate to determine the sum of all numbers from one to N. */

sum_rec_aux(0, Acc, Acc).
sum_rec_aux(N, Acc, Sum) :- N > 0,
                            N1 is N - 1,
                            Acc1 is Acc - N,
                            sum_rec_aux(N1, Acc1, Sum).

sum_rec(N, Sum) :- sum_rec(N, 0, Sum).

/* c) Implement the pow_rec(+X, +Y, -P) predicate, which recursively determines the result of raising X to the power of Y. */

pow_rec_aux(_, 0, Acc, Acc).
pow_rec_aux(X, Y, Acc, P) :- Y > 0,
                             Y1 is Y - 1,
                             Acc1 is Acc * X,
                             pow_rec_aux(X, Y1, Acc1, P).

pow_rec(X, Y, P) :- pow_rec_aux(X, Y, 1, P).

/* d) Implement the square_rec(+N, -S) predicate, which recursively determines que square of a number N (ie, without using multiplications). */

square_rec_aux(_, 0, Acc, Acc).
square_rec_aux(Value, Count, Acc, S) :- Count > 0,
                                        Acc1 is Acc + Value,
                                        Count1 is Count - 1,
                                        square_rec_aux(Value, Count1, Acc1, S).

square_rec(N, S) :- square_rec_aux(N, N, 0, S).

/* e) Implement the fibonacci(+N, -F) predicate, which determines the Fibonacci number of order N. */

fibonacci_aux(0, Acc1, _, Acc1).
fibonacci_aux(N, Acc1, Acc2, F) :- N > 0,
                                   NextAcc2 is Acc1 + Acc2,
                                   NextN is N - 1,
                                   fibonacci_aux(NextN, Acc2, NextAcc2, F).

fibonacci(N, F) :- 0fibonacci_aux(N, 0, 1, F)..

/* f) Implement collatz(+N, -S), which receives a positive integer number N and determines the number of steps necessary to reach 1 following the operations set forth by this sequence: if N is even, in the next step it will take the value N/2; if N is odd, in the next step it will take the value 3N+1. */

collatz_aux(1, Acc, Acc).
collatz_aux(N, Acc, S) :- N > 1,
                          N mod 2 =:= 0,
                          Acc1 is Acc + 1,
                          N1 is N // 2,
                          collatz_aux(N1, Acc1, S).
collatz_aux(N, Acc, S) :- N > 1,
                          N mod 2 =:= 1,
                          Acc1 is Acc + 1,
                          N1 is 3 * N + 1,
                          collatz_aux(N1, Acc1, S).

collatz(N, S) :- collatz_aux(N, 0, S).

/* g) Implement the is_prime(+X) predicate, which determines whether X is a prime number. Suggestion: a number is prime if it is divisible only by itself and one. */

check_divisors(X, Divisor) :- X mod Divisor =\= 0,
                              Divisor * Divisor > X, !.
                              check_divisors(X, NextDivisor).
check_divisors(X, Divisor) :- NextDivisor is Divisor + 2,

is_prime(2) :- !.
is_prime(X) :- X > 2,
               X mod 2 =\= 0,
               check_divisors(X, 3).
