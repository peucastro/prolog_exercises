% e) Implement count(+Elem, +List, ?N), which counts the number of occurrences (N) of Elem within List

count(_E, [], 0).
count(H, [H|T], N) :- count(H, T, N1),
                      N is N1 + 1.
count(E, [H|T], N) :- E \= H.
                      count(E, T, N),
