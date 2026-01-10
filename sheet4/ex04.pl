/*
Implement max(+A, +B, +C, ?Max), which determines the maximum value between three numbers.

Note: avoid behaviors such as shown below:
| ?- max(2,3,3,X).
X = 3 ? ;
X = 3 ? ;
no
*/

max(A, B, C, A) :- A >= B, A >= C, !.
max(A, B, C, B) :- B > A, B >= C, !.
max(_, _, C, C).
