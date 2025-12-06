/*
a) Represent information related to courses, teachers and students, according to the table
below, using predicates teaches/2 and attends/2, where the first argument of each
represents the taught or attended course.
*/

teaches(adalberto, algorithms).
teaches(bernardete, databases).
teaches(capitolino, compilers).
teaches(diogenes, statistics).
teaches(ermelinda, networks).

attends(alberto, algorithms).
attends(bruna, algorithms).
attends(cristina, algorithms).
attends(diogo, algorithms).
attends(eduarda, algorithms).

attends(antonio, databases).
attends(bruno, databases).
attends(cristina, databases).
attends(duarte, databases).
attends(eduardo, databases).

attends(alberto, compilers).
attends(bernardo, compilers).
attends(clara, compilers).
attends(diana, compilers).
attends(eurico, compilers).

attends(antonio, statistics).
attends(bruna, statistics).
attends(claudio, statistics).
attends(duarte, statistics).
attends(eva, statistics).

attends(alvaro, networks).
attends(beatriz, networks).
attends(claudio, networks).
attends(diana, networks).
attends(eduardo, networks).

/* b) Use the interpreter to answer the following questions:

% What courses does Diógenes teach?
teaches(diogenes, X).

% Does Felismina teach any course?
teaches(felismina, _X)

% What courses does Cláudio attend?
attends(claudio, X).

% Does Dalmindo attend any course?
attends(dalmindo, _X).

% Is Eduarda a student of Bernardete?
attends(eduarda, _X), teaches(bernardete, _X).
*/

/* c) Write rules in Prolog that allow answering the following questions: */

% Is X a student of professor Y?
% Who are the students of professor X?
% Who are the teachers of student X?
student(X, Y) :- attends(X, _S), teaches(Y, _S).

% Who is a student of both professor X and professor Y?
student_of_both(Z, X, Y) :- teaches(X, S1),
                            teaches(Y, S2),
                            attends(Z, S1),
                            attends(Z, S2),
                            X \= Y,
                            S1 \= S2.

% Who is colleagues with whom? (two students are colleagues if they attend at least one course in common; two teachers are colleagues)
colleagues(X, Y) :- teaches(X, _), teaches(Y, _), X \= Y.
colleagues(X, Y) :- attends(X, _S), attends(Y, _S), X \= Y.

% Who are the students that attend more than one course?
attends_more_than_1_course(X) :- attends(X, C1),
                                 attends(X, C2),
                                 C1 \= C2.
