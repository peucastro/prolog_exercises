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

/* f) Implement more_than_one_course(-L), which returns a list of all students attending more than one course. Note: avoid duplicate elements. */

more_than_one_course(L) :- setof(Student, C1^C2^(attends(Student, C1), attends(Student, C2), C1 \= C2), L).

/* g) Implement strangers(-L), which returns a list with all pairs of students who don't know each other, i.e., don't attend any course in common. */

strangers(L) :-
    setof(S1-S2,
          C1^C2^C^(
            attends(S1, C1), attends(S2, C2),
            S1 @< S2,
            \+ (attends(S1, C), attends(S2, C))
          ),
          L).

/* h) Implement good_groups(-L), which returns a list with all the students who attend more than one course in common. */

good_groups(L) :-
    setof(S1-S2,
          C1^C2^(
              attends(S1, C1), attends(S2, C1),
              attends(S1, C2), attends(S2, C2),
              C1 @< C2, S1 @< S2
          ),
          L).
