/* a) Implement list_size(+List, ?Size), which determines the size of List. */

list_size_aux([], Acc, Acc).
list_size_aux([_ | T], Acc, Size) :- Acc1 is Acc + 1,
                                     list_size_aux(T, Acc1, Size).

list_size(List, Size) :- list_size_aux(List, 0, Size).

/* b) Implement list_sum(+List, ?Sum), which sums the values contained in List (assumed to be a proper list of numbers). */

list_sum_aux([], Acc, Acc).
list_sum_aux([X | Xs], Acc, Sum) :- Acc1 is Acc + X,
                                    list_sum_aux(Xs, Acc1, Sum).

list_sum(List, Sum) :- list_sum_aux(List, 0, Sum).

/* c) Implement list_prod(+List, ?Prod), which multiplies the values in List (assumed to be a proper list of numbers). */

list_prod_aux([], Acc, Acc).
list_prod_aux([X | Xs], Acc, Prod) :- Acc1 is Acc * X,
                                      list_prod_aux(Xs, Acc1, Prod).

list_prod([X | Xs], Prod) :- list_prod_aux(Xs, X, Prod).

/* d) Implement inner_product(+List1, +List2, ?Result), which determines the inner product of two vectors (represented as lists of integers, of the same size). */

inner_product_aux([], [], Acc, Acc).
inner_product_aux([X | Xs], [Y | Ys], Acc, Result) :- Acc1 is Acc + X * Y,
                                                      inner_product_aux(Xs, Ys, Acc1, Result).

inner_product(List1, List2, Result) :- inner_product_aux(List1, List2, 0, Result).

/* e) Implement count(+Elem, +List, ?N), which counts the number of occurrences (N) of Elem within List. */

count_aux(_, [], Acc, Acc).
count_aux(Elem, [X | Xs], Acc, N) :- X == Elem,
                                     Acc1 is Acc + 1,
                                     count_aux(Elem, Xs, Acc1, N).
count_aux(Elem, [X | Xs], Acc, N) :- X \== Elem,
                                     count_aux(Elem, Xs, Acc, N).

count(Elem, List, N) :- count_aux(Elem, List, 0, N).
