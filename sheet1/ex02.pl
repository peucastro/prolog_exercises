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
| ?- teaches(adalberto, X).
X = algorithms ? ;
no

% Does Felismina teach any course?
| ?- teaches(felismina, _).
no

% What courses does Cláudio attend?
| ?- attends(claudio, X).
X = statistics ? ;
X = networks ? ;
no

% Does Dalmindo attend any course?
| ?- attends(dalmindo, _).
no

% Is Eduarda a student of Bernardete?
| ?- teaches(bernardete, _C), attends(eduarda, _C).
no
*/

/* c) Write rules in Prolog that allow answering the following questions: */

% Is X a student of professor Y?
% Who are the students of professor X?
% Who are the teachers of student X?
student(X, Y) :- teaches(Y, _C),
                 attends(X, _C).

% Who is a student of both professor X and professor Y?
student_of_both(S, X, Y) :- student(S, X),
                            student(S, Y),
                            X \= Y.

% Who is colleagues with whom? (two students are colleagues if they attend at least one course in common; two teachers are colleagues)
colleagues(X, Y) :- teaches(X, _),
                    teaches(Y, _),
                    X \= Y.

colleagues(X, Y) :- attends(X, _C),
                    attends(Y, _C),
                    X \= Y.

% Who are the students that attend more than one course?
attends_more_than_1_course(X) :- attends(X, _C1),
                                 attends(X, _C2),
                                 _C1 \= _C2.
