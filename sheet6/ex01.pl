/*
a) Implement map(+Pred, +List1, ?List2), with identical functionality to that of the maplist/3 predicate, from the lists library. Example:
double(X, Y):- Y is X*2.
| ?- map(double, [2,4,8], L).
L = [4,8,16] ?
yes
*/

double(X, Y) :- Y is X * 2.

map(_, [], []).
map(Pred, [H | T], [X | R]) :-
    call(Pred, H, X),
    map(Pred, T, R).

/*
b) Implement fold(+Pred, +StartValue, +List, ?FinalValue), with identical functionality to that of the scanlist/4 predicate from the lists library.
Example:
sum(A, B, S):- S is A+B.
| ?- fold(sum, 0, [2, 4, 6], F).
F = 12 ?
yes
*/

sum(A, B, S) :- S is A + B.

fold(_, StartValue, [], StartValue).
fold(Pred, StartValue, [H | T], FinalValue) :-
    call(Pred, StartValue, H, StartValue1),
    fold(Pred, StartValue1, T, FinalValue).

/*
c) Implement separate(+List, +Pred, -Yes, -No), which receives a list and a predicate, returning in Yes and No the elements X of List that make Pred(X) true or false, respectively.
even(X):- 0 =:= X mod 2.
| ?- separate([1,2,3,4,5], even, Y, N).
Y = [2,4],
N = [1,3,5] ?
yes
*/

even(X) :- 0 =:= X mod 2.

separate([], _, [], []).
separate([H | T], Pred, [H | Yes], No) :-
    call(Pred, H), !,
    separate(T, Pred, Yes, No).
separate([H | T], Pred, Yes, [H | No]) :-
    separate(T, Pred, Yes, No).

/*
d) Implement take_while(+Pred, +List, -Front, -Back), which identical functionality to that of the group/4 predicate from the lists library.
Example:
| ?- take_while(even, [2,4,6,7,8,9], F, B).
F = [2,4,6]
B = [7,8,9] ?
yes
*/

take_while(_, [], [], []).
take_while(Pred, [H | T], [], [H | T]) :- \+ call(Pred, H), !.
take_while(Pred, [H | T], [H | Front], Back) :-
    call(Pred, H),
    take_while(Pred, T, Front, Back).
