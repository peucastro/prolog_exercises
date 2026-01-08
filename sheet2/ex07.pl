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

ancestor_of(X, Y) :- parent(X, Y).
ancestor_of(X, Y) :- parent(X, Z),
                     ancestor_of(Z, Y).

descendant_of(X, Y) :- parent(Y, X).
descendant_of(X, Y) :- parent(Z, X),
                       descendant_of(Z, Y).
