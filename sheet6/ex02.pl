/* a) Implement my_functor/3, with identical functionality to that of the functor/3 predicate, using the =.. (univ) operator. */

my_functor(Term, Name, Arity) :-
    Term =.. [Name | Args],
    length(Args, Arity).

/* b) Implement my_arg/3, with identical functionality to that of the arg/3 predicate, using the =.. (univ) operator. */

:- use_module(library(lists)).

my_arg(Index, Term, Arg) :-
    Term =.. [_ | Args],
    nth1(Index, Args, Arg).
