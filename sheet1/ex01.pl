male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(cameron).
male(bo).
male(dylan).
male(alex).
male(luke).
male(rexford).
male(calhoun).
male(george).
male(poppy).

female(grace).
female(dede).
female(gloria).
female(claire).
female(barb).
female(manny).
female(pameron).
female(haley).
female(lily).

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
parent(barb, pameron).
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

father(X, Y) :- parent(X, Y),
                male(X).

mother(X, Y) :- parent(X, Y),
                female(X).

grandparent(X, Y) :- father(X, _K),
                     parent(_K, Y).

grandmother(X, Y) :- mother(X, _K),
                     parent(_K, Y).

siblings(X, Y) :- father(_F, X),
                  father(_F, Y),
                  mother(_M, X),
                  mother(_M, Y),
                  X \= Y.

halfSiblings(X, Y) :- father(_F, X), father(_F, Y),
                      mother(_M1, X), mother(_M2, Y),
                      _M1 \= _M2,
                      X \= Y.

halfSiblings(X, Y) :- mother(_M, X), mother(_M, Y),
                      father(_F1, X), father(_F2, Y),
                      _F1 \= _F2,
                      X \= Y.

cousins(X, Y) :- parent(_Z1, X),
                 parent(_Z2, Y),
                 siblings(_Z1, _Z2).

uncle(X, Y) :- parent(_K, Y),
               siblings(X, _K),
               male(X).

aunt(X, Y) :- parent(_K, Y),
               siblings(X, _K),
               female(X).
