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

/* a) Implement children(+Person, -Children), which returns in the second argument a list with the children of Person. */

children(Person, Children) :- setof(Child, parent(Person, Child), Children).

/* b) Implement children_of(+ListOfPeople, -ListOfPairs), which returns in the second argument a list with pairs in the format P-C, where P is an element of ListOfPeople and C is a list containing their children. */

children_of([], []).
children_of([P | Ps], [P-Children | Rest]) :- setof(Child, parent(P, Child), Children),
                                              children_of(Ps, Rest).

/*
d) Implement couple(?C), which unifies C with a couple of people (in the format X-Y) who have at least one child in common.
Example:
| ?- couple(phil-claire).
yes
| ?- couple(C).
C = dede-jay ?
*/

couple(X-Y) :- parent(X, _C),
               parent(Y, _C),
               X @< Y.

/* e) Implement couples(-List), which returns a list of all couples with children, avoiding duplicate results. */

couples(List) :- setof(X-Y, couple(X-Y), List).

/* f) Implement spouse_children(+Person, -SC), which returns in SC a pair Spouse/Children with a spouse of Person, and the children they have together. */

spouse_children(Person, Spouse/Children) :- couple(Person-Spouse),
                                            setof(Child, (parent(Person, Child), parent(Spouse, Child)), Children).
