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
/*
i. Who is Gloria's descendant, but not Jay's?

| ?- descendant_of(X, gloria), -+ descendant_of(X, jay).
X = manny ? ;
no
*/

/*
ii. What ancestors do Haley and Lily have in common?

| ?- ancestor_of(X, haley), ancestor_of(X, lily).
X = dede ? ;
X = jay ? ;
no
*/

born(jay, 1946-5-23).
born(claire, 1970-11-13).
born(mitchell, 1973-7-10).

before(Y1-_-_, Y2-_-_) :- Y1 < Y2.
before(Y-M1-_, Y-M2-_) :- M1 < M2.
before(Y-M-D1, Y-M-D2) :- D1 < D2.

older(X, Y, X) :- born(X, _BX),
                  born(Y, _BY),
                  before(_BX, _BY).
older(X, Y, Y) :- born(X, _BX),
                  born(Y, _BY),
                  before(_BY, _BX).

oldest(X) :- born(X, _BX),
             \+ (born(Y, _BY), before(_BY, _BX)).
