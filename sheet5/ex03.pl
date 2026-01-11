%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '2 Tue', 15, 2).
class(ipc, tp, '4 Thu', 16, 1.5).
class(pfl, tp, '2 Tue', 10.5, 2).
class(fsi, t, '1 Mon', 10.5, 2).
class(lbaw, t, '3 Wed', 10.5, 2).
class(fsi, tp, '5 Fri', 8.5, 2).
class(lbaw, tp, '3 Wed', 8.5, 2).
class(rc, t, '5 Fri', 10.5, 2).
class(ipc, t, '4 Thu', 14.5, 1.5).
class(rc, tp, '1 Mon', 8.5, 2).

/* a) Implement same_day(+Course1, +Course2), which succeeds if there are classes of both Course1 and Course2 taking place on the same day. */

same_day(C1, C2) :- class(C1, _, Day, _, _),
                    class(C2, _, Day, _, _),
                    C1 @< C2,
                    !.

/* b) Implement daily_courses(+Day, -Courses), which receives a day of the week and returns a list with all the courses taking place on that day. */

daily_courses(Day, Courses) :- setof(Course, Type^Time^Duration^(class(Course, Type, Day, Time, Duration)), Courses).

/* c) Implement short_classes(-L), which returns in L a list of all classes with a duration of less than 2 hours (list of terms in the format UC-Day/Time). */

short_classes(L) :- findall(UC-Day/Time, (class(UC, _, Day, Time, Duration), Duration < 2), L).

/* d) Implement course_classes(+Course, -Classes), which receives a course and returns a list of all the classes from that course (list of terms in the format Day/Time-Type). */

course_classes(Course, Classes) :- findall(Day/Time-Type, (class(Course, Type, Day, Time, _)), Classes).

/* e) Implement courses(-L), which returns a list of all existing courses. Avoid repeated results. */

courses(L) :- setof(Course, Type^Day^Time^Duration^(class(Course, Type, Day, Time, Duration)), L).

/* f) Implement schedule/0, which prints all the classes in the terminal, in the order by which they take place during the week. */

print_classes([]).
print_classes([Day-Time-Duration/Course-Type | Tail]) :- format('~w ~wh (~w hrs): ~w (~w)~n', [Day, Time, Duration, Course, Type]),
                                                         print_classes(Tail).

schedule :- setof(Day-Time-Duration/Course-Type, class(Course, Type, Day, Time, Duration), Schedule),
            print_classes(Schedule).

/* g) Modify the previous predicates so that the day of the week is printed only as Mon, Tue, Wed, Thu or Fri.
Tip: use a 'translation' predicate to convert between the internal representation format and the display format. */

clean_day('1 Mon', 'Mon').
clean_day('2 Tue', 'Tue').
clean_day('3 Wed', 'Wed').
clean_day('4 Thu', 'Thu').
clean_day('5 Fri', 'Fri').

print_classes_clean([]).
print_classes_clean([Day-Time-Duration/Course-Type | Tail]) :- clean_day(Day, CleanDay),
                                                               format('~w ~wh (~w hrs): ~w (~w)~n', [CleanDay, Time, Duration, Course, Type]),
                                                               print_classes_clean(Tail).

schedule_clean :- setof(Day-Time-Duration/Course-Type, class(Course, Type, Day, Time, Duration), Schedule),
                  print_classes_clean(Schedule).

/* h) Implement find_class/0, which asks the user for a day and time, and indicates whether a class starts or is taking place at that time, printing the class, start time and duration.
If no class is taking place, the predicate should display a message stating that. */

find_class :- write('Day: '), read(InputDay),
              write('Time: '), read(QueryTime),
              (
                clean_day(InternalDay, InputDay),
                class(UC, Type, InternalDay, Start, Duration),
                End is Start + Duration,
                QueryTime >= Start,
                QueryTime < End
              ->
                format('~w ~wh (~w hrs): ~w (~w)~n', [InputDay, Start, Duration, UC, Type])
              ;
                format('No class found on ~w at ~w~n', [InputDay, QueryTime])
              ).
