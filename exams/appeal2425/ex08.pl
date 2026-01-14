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

read_book(bernardete, 'The Firm').
read_book(bernardete, 'The Client').
read_book(clarice, 'The Firm').
read_book(clarice, 'Carrie').
read_book(deirdre, 'The Firm').
read_book(deirdre, 'Next').

/*
The Passionate Fans of Literature (PFL) Book Club keeps a record of all books read by its members, as exemplified in the following code:

read_book(bernardete, 'The Firm').
read_book(bernardete, 'The Client').
read_book(clarice, 'The Firm').
read_book(clarice, 'Carrie').
read_book(deirdre, 'The Firm').
read_book(deirdre, 'Next').

A book can be considered popular if it has been read by at least 75% of all the members of the PFL Book Club.

Implement popular(?Title), which unifies Title with the title of a book considered popular. Example:

| ?- popular('The Client').
no
| ?- popular(Title).
Title 'The Firm' ? ;
no
*/

popular(Title) :-
    setof(Member, (Book)^(read_book(Member, Book)), Members),
    length(Members, MembersCount),
    setof(MemberRead, read_book(MemberRead, Title), MembersRead),
    length(MembersRead, MembersReadCount),
    MembersReadCount / MembersCount >= 0.75.
