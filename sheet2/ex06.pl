/*
a) Implement gcd(+X, +Y, -G), which receives two positive integer numbers, X and Y, and determines the greatest common divisor (gcd) using Euclid's algorithm.
This method recursively determines the gcd between two numbers in the following manner:
the gcd between X and Y is X when Y is zero; otherwise, it is the gcd between Y and X mod Y.
*/

gcd(X, 0, X) :- X > 0.
gcd(X, Y, G) :- X > 0,
                Y > 0,
                X1 is X mod Y,
                gcd(Y, X1, G).

/*
b) Implement lcm(+X, +Y, -M), which receives two positive integer numbers, X and Y,
and determines the least common multiple, which can be given by lcm(X, Y) = X.Y / gcd(X, Y).
*/

lcm(X, Y, M) :- X > 0,
                Y > 0,
                gcd(X, Y, D),
                M is X * Y // D.
