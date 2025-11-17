female(grace).
male(frank).
female(dede).
male(jay).
female(gloria).
male(javier).
male(barb).
male(merle).
male(phil).
female(claire).
male(mitchell).
male(joe).
female(manny).
male(cameron).
female(pameron).
make(bo).
male(dylan).
female(haley).
male(alex).
male(luke).
female(lily).
male(rexford).
male(calhoun).
male(george).
male(poppy).

parent(grace, phil).
parent(frank, phil).
parent(dede, claire).
parent(dede, mitchell).
parent(jay, claire).
parent(jay, mitchell).
parent(jay, joe).
parent(gloria, joe).
parent(gloria, manny).
parent(javier, manny).
parent(barb, cameron).
parent(bard, pameron).
parent(merle, cameron).
parent(merle, pameron).
parent(phil, haley).
parent(phil, alex).
parent(phil, luke).
parent(claire, haley).
parent(claire, alex).
parent(claire, luke).
parent(mitchell, lily).
parent(mitchell, rexford).
parent(cameron, lily).
parent(cameron, rexford).
parent(pameron, calhoun).
parent(bo, calhoun).
parent(dylan, george).
parent(dylan, poppy).
parent(haley, george).
parent(haley, poppy).

/*
| ?- female(haley).
yes
| ?- male(gil).
no
| ?- parent(frank, phil).
yes
| ?- parent(X, claire).
X = dede ? ;
X = jay ?
yes
| ?- parent(gloria, X).
X = joe ? ;
X = manny ? ;
no
| ?- parent(jay, X), parent(X, Y).
X = claire,
Y = haley ? ;
X = claire,
Y = alex ? ;
X = claire,
Y = luke ? ;
X = mitchell,
Y = lily ? ;
X = mitchell,
Y = rexford ? ;
no
| ?- parent(X, lily), parent(Y, X).
X = mitchell,
Y = dede ? ;
X = mitchell,
Y = jay ? ;
X = cameron,
Y = barb ? ;
X = cameron,
Y = merle ? ;
no
| ?- parent(alex, X).
no
| ?- parent(X, luke), parent(X, Y), Y \= luke.
X = phil,
Y = haley ? ;
X = phil,
Y = alex ? ;
X = claire,
Y = haley ? ;
X = claire,
Y = alex ? ;
no
*/

father(X, Y) :-
    male(X),
    parent(X, Y).

grandfather(X, Y) :-
    male(X),
    parent(X, K),
    parent(K, Y).

grandmother(X, Y) :-
    female(X),
    parent(X, K),
    parent(K, Y).

siblings(X, Y) :-
    parent(P, X),
    parent(P, Y),
    parent(M, X),
    parent(M, Y),
    X \= Y,
    P \= M.

halfSiblings(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y,
    \+ siblings(X, Y).

cousins(X, Y) :-
    parent(X1, X),
    parent(Y1, Y),
    siblings(X1, Y1),
    X \= Y.

uncle(X, Y) :-
    parent(P, Y),
    siblings(P, X).

