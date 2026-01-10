immature(X):- adult(X), !, fail.
immature(_X).

/*
RED cut

backtracks to the second clause if the cut is removed, causing a different result.
*/

adult(X):- person(X), !, age(X, N), N >=18.
adult(X):- turtle(X), !, age(X, N), N >=50.
adult(X):- spider(X), !, age(X, N), N>=1.
adult(X):- bat(X), !, age(X, N), N >=5.

/*
RED cut

prevents backtracking to other categories if the age check fails.
*/
