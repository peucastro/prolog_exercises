%author(AuthorID, Name, YearOfBirth, CountryOfBirth)
author(1, 'John Grisham', 1955, 'USA').
author(2, 'Wilbur Smith', 1933, 'Zambia').
author(3, 'Stephen King', 1947, 'USA').
author(4, 'Michael Crichton', 1942, 'USA').

%book(Title, AuthorID, YearOfRelease, Pages, Genres).
book('The Firm', 1, 1991, 432, ['Legal thriller']).
book('The Client', 1, 1993, 422, ['Legal thriller']).
book('The Runaway Jury', 1, 1996, 414, ['Legal thriller']).
book('The Exchange', 1, 2023, 338, ['Legal thriller']).
book('Carrie', 3, 1974, 199, ['Horror']).
book('The Shining', 3, 1977, 447, ['Gothic novel', 'Horror', 'Psychological horror']).
book('Under the Dome', 3, 2009, 1074, ['Science fiction', 'Political']).
book('Doctor Sleep', 3, 2013, 531, ['Horror', 'Gothic', 'Dark fantasy']).
book('Jurassic Park', 4, 1990, 399, ['Science fiction']).
book('Prey', 4, 2002, 502, ['Science fiction', 'Techno-thriller', 'Horror', 'Nanopunk']).
book('Next', 4, 2006, 528, ['Science fiction', 'Techno-thriller', 'Satire']).

/*
Implement filterArgs(+Term, Indexes, ?NewTerm), which receives a Prolog Term as the first argument and a list of Indexes (starting at 1, you can assume the values are positive integers, sorted ascendingly), unifying the third argument with a new term containing only the arguments in the positions indicated by the indexes in the list. Examples:

| ?- filterArgs(book('The Firm', 1, 1991, 432, ['Legal thriller']), [1, 3, 5], NewTerm).
NewTerm = book('The Firm', 1991, ['Legal thriller']).
| ?- filterArgs(author(1, 'John Grisham', 1955, USA), [2, 3], NewTerm).
NewTerm = author('John Grisham', 1955).
*/

filter_by_indexes(_, [], _, []).
filter_by_indexes([H | T], [I | Indexes], Curr, [H | Filtered]) :-
    I =:= Curr, !,
    Next is Curr + 1,
    filter_by_indexes(T, Indexes, Next, Filtered).
filter_by_indexes([_ | T], [I | Indexes], Curr, Filtered) :-
    Curr < I,
    Next is Curr + 1,
    filter_by_indexes(T, [I | Indexes], Next, Filtered).

filterArgs(Term, Indexes, NewTerm) :-
    Term =.. [Name | Args],
    filter_by_indexes(Args, Indexes, 1, NewArgs),
    NewTerm =.. [Name | NewArgs].
