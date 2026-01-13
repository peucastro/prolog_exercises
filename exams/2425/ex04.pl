%author(AuthorID, Name, YearOfBirth, CountryOfBirth).
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
The Jaccard coefficient, also known as intersection over union (IoU), is a similarity measurement between two sets, determined by the division between the intersection (number of common elements between the two sets) and the union (total number of different elements in both sets).
Implement the similarity(?Title1, ?Title2, ?Similarity) predicate, which determines the Jaccard coefficient between the two books received as first two arguments, considering the genres of each book as the measure of similarity.
Example:
| ?- similarity('The Firm', 'The Client', Sim).
Sim = 1.0 ? ;
no
| ?- similarity('Prey', 'Next', Sim).
Sim = 0.4 ?
yes
*/

intersection([], _, []).
intersection([H1 | T1], L2, [H1 | T]) :-
    memberchk(H1, L2), !,
    intersection(T1, L2, T).
intersection([_ | T1], L2, T) :- intersection(T1, L2, T).

union([], L, L).
union(L, [], L).
union(L1, L2, Union) :-
    append(L1, L2, L),
    sort(L, Union).

similarity(Title1, Title2, Similarity) :-
    book(Title1, _, _, _, Genres1),
    book(Title2, _, _, _, Genres2),
    intersection(Genres1, Genres2, I),
    length(I, IL),
    union(Genres1, Genres2, U),
    length(U, UL),
    Similarity is IL / UL.
