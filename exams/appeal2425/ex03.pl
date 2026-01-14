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
Implement youngest_author(?Author), which unifies Author with the name of the person who became an author at the youngest age.
If more than one author published their first book at the same age, different results should be provided via backtracking. Example:

| ?- youngest_author(Author).
Author = 'Stephen King ? ;
no
*/

author_wrote_book_at_age(Author, Title, Age) :-
    author(AuthorID, Author, YearOfBirth, _),
    book(Title, AuthorID, YearOfRelease, _, _),
    Age is YearOfRelease - YearOfBirth.

youngest_author(Author) :-
    author_wrote_book_at_age(Author, _, Age),
    \+ (
        author_wrote_book_at_age(_, _, Age1),
        Age1 < Age
    ).
