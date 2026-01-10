/* a) Implement print_full_list(+L), which receives a list and prints it to the terminal using spaces in addition to commas to separate elements in the list. */

print_full_list([]) :- !.
print_full_list([X]) :- write(X), !.
print_full_list([X | Xs]) :- write(X),
                             write(', '),
                             print_full_list(Xs).

/*
c) Implement print_matrix(+M), which prints a list of lists, with each list in a line, and formatted as above.
Example:
| ?- print_matrix([[a,b,c], [d,e,f], [g,h,i]]).
[a, b, c]
[d, e, f]
[g, h, i]
yes
*/

print_matrix_row(R) :- put_char('['),
                       print_full_list(R),
                       put_char(']'),
                       nl, !.

print_matrix([]) :- !.
print_matrix([Xs]) :- print_matrix_row(Xs), !.
print_matrix([Xs | Xss]) :- print_matrix_row(Xs),
                            print_matrix(Xss).

/*
d) Create a new version of the predicate above, print_numbered_matrix(+L), that prints the matrix with a line number before each line.
Note that the matrix may have more than nine lines, so the numbers should be padded to ensure a correct number alignment.
Example:
| ?- length(_L, 100), maplist(=([a,b,c,d]), _L), print_numbered_matrix(_L).
1   [a, b, c, d]
    ( ... )
99  [a, b, c, d]
100 [a, b, c, d]
yes
*/

:- use_module(library(lists)).

print_numbered_matrix_row(R, N) :- write(N),
                                   put_char(' '),
                                   put_char('['),
                                   print_full_list(R),
                                   put_char(']'),
                                   nl, !.

print_numbered_matrix_aux([], _) :- !.
print_numbered_matrix_aux([Xs], Index) :- print_numbered_matrix_row(Xs, Index), !.
print_numbered_matrix_aux([Xs | Xss], Index) :- print_numbered_matrix_row(Xs, Index),
                                                Index1 is Index + 1,
                                                print_numbered_matrix_aux(Xss, Index1).

print_numbered_matrix(L) :- print_numbered_matrix_aux(L, 1).

/*
e) Implement print_list(+L, +S, +Sep, +E), which prints a list using S as a starting symbol, Sep as the separator between elements, and E as the end symbol.
Example:
| ?- print_list([a,b,c,d,e], '[', ', ', ']').
[a, b, c, d, e]
yes
| ?- print_list([a,b,c,d,e], '< ', ' | ', ' >').
< a | b | c | d | e >
yes
*/

print_full_list_sep([], _) :- !.
print_full_list_sep([X], _) :- write(X), !.
print_full_list_sep([X | Xs], Sep) :- write(X),
                                      write(Sep),
                                      print_full_list_sep(Xs, Sep).

print_list(L, S, Sep, E) :- write(S),
                            print_full_list_sep(L, Sep),
                            write(E).
