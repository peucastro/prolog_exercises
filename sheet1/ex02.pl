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
