/* a) Implement list_append(?L1, ?L2, ?L3), where L3 is the concatenation of lists L1 and L2. */

list_append([], L2, L2).
list_append([X | Xs], L2, [X | L3]) :- list_append(Xs, L2, L3).

/* b) Implement list_member(?Elem, ?List), which verifies if Elem is a member of List, using solely the append predicate exactly once. */

list_member(Elem, List) :- append(_, [Elem | _], List).

/* c) Implement list_last(+List, ?Last), which unifies Last with the last element of List, using solely the append predicate exactly once. */

list_last(List, Last) :- append(_, [Last], List).

/* d) Implement list_nth(?N, ?List, ?Elem), which unifies Elem with the Nth element of List, using only the append and length predicates. */

list_nth(N, List, Elem) :- append(Prefix, [Elem | _], List),
                           length(Prefix, N).

/* e) Implement list_append(+ListOfLists, ?List), which appends a list of lists. */

list_append_aux([], Acc, Acc).
list_append_aux([Xs | Xss], Acc, List) :- append(Acc, Xs, Acc1),
                                          list_append_aux(Xss, Acc1, List).

list_append(ListOfLists, List) :- list_append_aux(ListOfLists, [], List).

/* f) Implement list_del(+List, +Elem, ?Res), which eliminates an occurrence of Elem from List, unifying the result with Res, using only the append predicate twice. */

list_del(List, Elem, Res) :- append(Prefix, [Elem | Suffix], List),
                             append(Prefix, Suffix, Res).

/* g) Implement list_before(?First, ?Second, ?List), which succeeds if the first two arguments are members of List, and First occurs before Second, using only the append predicate twice. */

list_before(First, Second, List) :- append(_, [First | Rest], List),
                                    append(_, [Second | _], Rest).

/* h) Implement list_replace_one(+X, +Y, +List1, ?List2), which replaces one occurrence of X in List1 by Y, resulting in List2, using only the append predicate twice. */

list_replace_one(X, Y, List1, List2) :- append(Prefix, [X | Rest], List1),
                                        append(Prefix, [Y | Rest], List2).

/* i) Implement list_repeated(+X, +List), which succeeds if X occurs repeatedly (at least twice) in List, using only the append predicate twice. */

list_repeated(X, List) :- append(_, [X | Rest], List),
                          append(_, [X | _], Rest).

/* j) Implement list_slice(+List1, +Index, +Size, ?List2), which extracts a slide of size Size from List1 starting at index Index, resulting in List2, using only the append and length predicates. */

list_slice(List, Index, Size, List2) :- append(Prefix, Suffix, List),
                                        length(Prefix, Index),
                                        append(List2, _, Suffix),
                                        length(List2, Size).

/*
k) Implement list_shift_rotate(+List1, +N, ?List2), which rotates List1 by N elements to the left, resulting in List2, using only the append and length predicates.
E.g.: | ?- list_shift_rotate([a, b, c, d, e, f], 2, L).
      L = [c, d, e, f, a, b]
*/

list_shift_rotate(List1, N, List2) :- length(Prefix, N),
                                      append(Prefix, Suffix, List1),
                                      append(Suffix, Prefix, List2).
