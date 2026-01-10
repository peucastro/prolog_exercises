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
del_all(Elem, [Elem | Xs], List2) :- del_all(Elem, Xs, List2).
del_all(Elem, [X | Xs], [X | List2]) :- X \== Elem,
                                        del_all(Elem, Xs, List2).

/* d) Implement del_all_list(+ListElems, +List1, ?List2), which deletes from List1 all occurrences of all elements of ListElems, resulting in List2. */

del_all_list([], List1, List1).
del_all_list([Target | ListElems], List1, List2) :- del_all(Target, List1, TempList),
                                                    del_all_list(ListElems, TempList, List2).

/* e) Implement del_dups(+List1, ?List2), which eliminates repeated values from List1. */

del_dups_aux([], _, []).
del_dups_aux([X | Xs], Acc, List2) :- memberchk(X, Acc),
                                      del_dups_aux(Xs, Acc, List2).
del_dups_aux([X | Xs], Acc, [X | List2]) :- \+ memberchk(X, Acc),
                                            del_dups_aux(Xs, [X | Acc], List2).

del_dups(List1, List2) :- del_dups_aux(List1, [], List2).

/* g) Implement replicate(+Amount, +Elem, ?List) which generates a list with Amount repetitions of Elem. */

replicate(0, _, []).
replicate(Amount, Elem, [Elem | List]) :- Amount > 0,
                                          Amount1 is Amount - 1,
                                          replicate(Amount1, Elem, List).

/* h) Implement intersperse(+Elem, +List1, ?List2), which intersperses Elem between the elements of List1, resulting in List2. */

intersperse(_, [], []).
intersperse(_, [X], [X]) :- !.
intersperse(Elem, [X | Xs], [X, Elem | List2]) :- intersperse(Elem, Xs, List2).

/* i) Implement insert_elem(+Index, +List1, +Elem, ?List2), which inserts Elem into List1 at position Index, resulting in List2. */

insert_elem(0, [], X, [X]).
insert_elem(0, List1, Elem, [Elem | List1]).
insert_elem(Index, [X | Xs], Elem, [X | List2]) :- Index > 0,
                                                   Index1 is Index - 1,
                                                   insert_elem(Index1, Xs, Elem, List2).

/* j) Implement delete_elem(+Index, +List1, ?Elem, ?List2), which removes the element at position Index from List1 (which is unified with Elem), resulting in List2. */

delete_elem(0, [X | Xs], X, Xs).
delete_elem(Index, [X | Xs], Elem, [X | List2]) :- Index > 0,
                                                   Index1 is Index - 1,
                                                   delete_elem(Index1, Xs, Elem, List2).

/* k) Implement replace(+List1, +Index, ?Old, +New, ?List2), which replaces the Old element, located at position Index in List1, by New, resulting in List2. */

replace([X | Xs], 0, X, New, [New | Xs]).
replace([X | Xs], Index, Old, New, [X | List2]) :- Index > 0,
                                                   Index1 is Index - 1,
                                                   replace(Xs, Index1, Old, New, List2).
