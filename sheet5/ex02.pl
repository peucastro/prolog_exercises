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

/* a) Implement teachers(-T) which returns a list with all the teachers. */

teachers(T) :- setof(Teacher, Subject^teaches(Teacher, Subject), T).

/*
b) How does the predicate implemented above behave in case a teacher teaches more than one course? How can you prevent duplicates?

it filters duplicates using a set
*/

/* c) Implement students_of(+T, -S) which returns a list with all the students of professor T. */

students_of(T, S) :- setof(Student, Subject^(teaches(T, Subject), attends(Student, Subject)), S).

/* d) Implement teachers_of(+S, -T) which returns a list with all teachers of student S. */

teachers_of(S, T) :- setof(Teacher, Subject^(attends(S, Subject), teaches(Teacher, Subject)), T).

/* e) Implement common_courses(+S1, +S2, -C), which returns a list of all courses attended by both student S1 and S2. */

common_courses(S1, S2, C) :- setof(Course, (attends(S1, Course), attends(S2, Course)), C).
