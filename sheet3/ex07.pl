/* a) Implement is_ordered(+List), which succeeds if List is a proper list of integers, in increasing order. */

is_ordered([]).
is_ordered([_]).
is_ordered([N, X | Xs]) :- N < X,
                           is_ordered([X | Xs]).

/* b) Implement insert_ordered(+Value, +List1, ?List2), which inserts Value into List1 (assumed to be ordered), maintaining the ordering of the elements, resulting in List2. */

insert_ordered(Value, [], [Value]).
insert_ordered(Value, [X | Xs], [Value, X | Xs]) :- Value =< X.
insert_ordered(Value, [X | Xs], [X | List2]) :- Value > X,
                                                insert_ordered(Value, Xs, List2).

/* c) Implement insert_sort(+List, ?OrderedList), which orders List, resulting in OrderedList. */

insert_sort([], []).
insert_sort([X | Xs], OrderedList) :- insert_sort(Xs, SortedTail),
                                      insert_ordered(X, SortedTail, OrderedList).
