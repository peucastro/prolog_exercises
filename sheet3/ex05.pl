/* a) Implement list_to(+N, ?List), which unifies List with a list containing all the integer numbers from 1 to N. */

list_to_aux(1, Acc, [1 | Acc]).
list_to_aux(N, Acc, List) :- N > 0,
                             N1 is N - 1,
                             list_to_aux(N1, [N | Acc], List).

list_to(N, List) :- list_to_aux(N, [], List).

/* b) Implement list_from_to(+Inf, +Sup, ?List), which unifies List with a list containing all the integer numbers between Inf and Sup (both included). */

list_from_to_aux(X, X, Acc, [X | Acc]).
list_from_to_aux(Inf, Current, Acc, List) :- Current >= Inf,
                                             Next is Current - 1,
                                             list_from_to_aux(Inf, Next, [Current | Acc], List).

list_from_to(Inf, Sup, List) :- list_from_to_aux(Inf, Sup, [], List).

/* c) Implement list_from_to_step(+Inf, +Sup, +Step, ?List), which unifies List with a list containing integer numbers between Inf and Sup, in increments of Step. */

list_from_to_step(Inf, Sup, _Step, []) :- Inf > Sup.
list_from_to_step(Inf, Sup, Step, [Inf | Rest]) :- Inf =< Sup,
                                                   Next is Inf + Step,
                                                   list_from_to_step(Next, Sup, Step, Rest).
