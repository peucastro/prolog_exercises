/* a) Implement invert(+List1, ?List2), which inverts list List1. */

invert_aux([], Acc, Acc).
invert_aux([X | Xs], Acc, List2) :- invert_aux(Xs, [X | Acc], List2).

invert(List1, List2) :- invert_aux(List1, [], List2).

/* b) Implement del_one(+Elem, +List1, ?List2), which deletes the first occurrence of Elem from List1, resulting in List2. */

del_one(_, [], []).
del_one(Elem, [Elem | Xs], Xs).
del_one(Elem, [X | Xs], [X | List2]) :- X \= Elem,
                                        del_one(Elem, Xs, List2).

/* c) Implement del_all(+Elem, +List1, ?List2), which deletes all occurrences of Elem from List1, resulting in List2 */

del_all(_, [], []).
del_all(Elem, [X | Xs], List2) :- X == Elem,
                                  del_all(Elem, Xs, List2).
del_all(Elem, [X | Xs], [X | List2]) :- X \== Elem,
                                        del_all(Elem, Xs, List2).

/* d) Implement del_all_list(+ListElems, +List1, ?List2), which deletes from List1 all occurrences of all elements of ListElems, resulting in List2. */

del_all_list(_, [], []).
del_all_list(ListElems, [X | Xs], List2) :- memberchk(X, ListElems),
                                            del_all_list(ListElems, Xs, List2).
del_all_list(ListElems, [X | Xs], [X | List2]) :- \+ memberchk(X, ListElems),
                                                  del_all_list(ListElems, Xs, List2).

/* e) Implement del_dups(+List1, ?List2), which eliminates repeated values from List1. */

del_dups_aux([], _, []).
del_dups_aux([X | Xs], Acc, List2) :- memberchk(X, Acc),
                                      del_dups_aux(Xs, Acc, List2).
del_dups_aux([X | Xs], Acc, [X | List2]) :- \+ memberchk(X, Acc),
                                            del_dups_aux(Xs, [X | Acc], List2).

del_dups(List1, List2) :- del_dups_aux(List1, [], List2).
