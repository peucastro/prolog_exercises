% country(Country, Capital, Continent, Population)
country('Bolivia', 'Bogota', 'South America', 12.08).

% borders(Country, ListOfNeighbors)
borders('Bolivia', ['Chile'-861, 'Peru'-4300]).

is_enclave(X) :- borders(X, [_]).

long_border_neighbors(MinLength, Country1, Country2) :-
    borders(Country1, Neighbors),
    member(Country2-BorderLength, Neighbors),
    MinLength =< BorderLength.

neighbor_capitals_aux([], []).
neighbor_capitals_aux([Neighbor-_ | Xs], [Capital | Capitals]) :-
    country(Neighbor, Capital, _, _),
    neighbor_capitals_aux(Xs, Capitals).

neighbor_capitals(Country, Capitals) :-
    borders(Country, Neighbors),
    neighbor_capitals_aux(Neighbors, Capitals).

largest_population_of_continent(Continent, Country) :-
    country(Country, _, Continent, Population1),
    \+ ((
        country(_, _, Continent, Population2),
        Population2 > Population1
    )).

second_largest_population_of_continent(Continent, Country) :-
    largest_population_of_continent(Continent, CountryMax),
    country(CountryMax, _, Continent, PopulationMax),
    country(Country, _, Continent, Population),
    Population < PopulationMax,
    \+ ((
        country(_, _, Continent, PopulationC),
        PopulationC < PopulationMax,
        PopulationC > Population
    )).

similar_neighbors(Country, Neighbor1, Neighbor2) :-
    borders(Country, Neighbors),
    append(_ , [Neighbor1-Length1, Neighbor2-Length2 | _], Neighbors),
    Length2 - Length1 < 1000.

are_borders_sorted(Borders) :-
    \+ ((
        append(_ , [_-Length1, _-Length2 | _], Borders),
        Length2 < Length1
    )).

print_countries :-
    country(Country, Capital, Continent, _),
    write(Capital), write(', capital of '),
    write(Country), write(', in '),
    write(Continent), nl,
    fail.
print_countries.

get_countries_aux(Acc, Countries) :-
    country(Country, _, _, _),
    \+ member(Country, Acc),
    !,
    get_countries_aux([Country | Acc], Countries).
get_countries_aux(Acc, Acc).

get_countries(Countries) :-
    get_countries_aux([], Countries).

big_country_continent_capitals(MinPopulation, Continent, Capitals) :-
    setof(Capital, (Country, Population)^(
        country(Country, Capital, Continent, Population),
        Population >= MinPopulation
    ), Capitals).

:- use_module(library(lists)).

most_populated_neighbors(Country, CountryList) :-
    borders(Country, Neighbors),
    setof(Population-Neighbor, (Length, Capital, Continent)^(
        member(Neighbor-Length, Neighbors),
        country(Neighbor, Capital, Continent, Population)
    ), Pairs),
    reverse(Pairs, DescPairs),
    findall(N, member(_-N, DescPairs), CountryList).

dfs([C2 | _], C2, [C2]).
dfs([Ca | T], C2, [Ca | Trajectory]) :-
    borders(Ca, L),
    member(Cb-_, L),
    \+ member(Cb, T),
    dfs([Cb, Ca | T], C2, Trajectory).

trajectory(C1, C2, Trajectory) :-
    dfs([C1], C2, Trajectory).
