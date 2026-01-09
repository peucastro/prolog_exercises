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
