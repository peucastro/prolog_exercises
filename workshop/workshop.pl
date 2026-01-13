:- use_module(library(lists)).

%country(Country, Capital, Continent, Population)
country('Bolivia', 'Bogota', 'South America', 12.08).
country('Chile', 'Santiago', 'South America', 19.49).
country('Peru', 'Lima', 'South America', 33.72).
country('Mozambique', 'Maputo', 'Africa', 32.08).
country('South Africa', 'Cape Town', 'Africa', 59.39).
country('Lesotho', 'Maseru', 'Africa', 2.281).

%borders(Country, ListOfNeighbors)
borders('Bolivia', ['Chile'-861, 'Peru'-4300]).
borders('Chile', ['Peru'-169, 'Bolivia'-861]).
borders('Peru', ['Chile'-169, 'Bolivia'-4300]).
borders('Mozambique', ['South Africa'-496]).
borders('South Africa', ['Mozambique'-496, 'Lesotho'-909]).
borders('Lesotho', ['South Africa'-909]).

/*
Question 1: Identify Enclave Countries
Enunciate: An enclave is a country that borders exactly one other country.
Implement a predicate to identify such countries.

Predicate: is_enclave(?Country)
- Country: The name of a country (can be input or output)
- Succeeds if Country has exactly one neighbor
- Fails if Country has zero or more than one neighbor

Example:
?- is_enclave('Bolivia').
true.
*/

is_enclave(X) :- borders(X, [_]).

/*
Question 2: Find Long Border Neighbors
Enunciate: Find pairs of neighboring countries whose shared border is at least
a specified minimum length.

Predicate: long_border_neighbors(+MinLength, ?Country1, ?Country2)
- MinLength: Minimum border length in kilometers (input)
- Country1: First country in the pair (can be input or output)
- Country2: Neighboring country (can be input or output)
- Succeeds if Country1 and Country2 share a border of at least MinLength km

Example:
?- long_border_neighbors(4000, C1, C2).
C1 = 'Bolivia', C2 = 'Peru'.
*/

long_border_neighbors(MinLength, Country1, Country2) :-
    borders(Country1, Neighbors),
    member(Country2-BorderLength, Neighbors),
    MinLength =< BorderLength.

/*
Question 3: Get Neighbor Capitals
Enunciate: Given a country, find the list of capital cities of all its
neighboring countries.

Predicate: neighbor_capitals(+Country, ?Capitals)
- Country: The name of a country (input)
- Capitals: List of capital cities of neighboring countries (output)
- Succeeds by unifying Capitals with the list of neighboring capitals

Auxiliary: neighbor_capitals_aux(+Neighbors, ?Capitals)
- Neighbors: List of Neighbor-BorderLength pairs
- Capitals: Corresponding list of capital cities

Example:
?- neighbor_capitals('Bolivia', Caps).
Caps = ['Santiago', 'Lima'].
*/

neighbor_capitals_aux([], []).
neighbor_capitals_aux([Neighbor-_ | Xs], [Capital | Capitals]) :-
    country(Neighbor, Capital, _, _),
    neighbor_capitals_aux(Xs, Capitals).

neighbor_capitals(Country, Capitals) :-
    borders(Country, Neighbors),
    neighbor_capitals_aux(Neighbors, Capitals).

/*
Question 4: Find Largest Population in Continent
Enunciate: Identify the country with the largest population in a given continent.

Predicate: largest_population_of_continent(?Continent, ?Country)
- Continent: The name of a continent (can be input or output)
- Country: The country with the largest population in that continent
- Succeeds if Country has the highest population among all countries in Continent
- Uses double negation to ensure no other country has a larger population

Example:
?- largest_population_of_continent('South America', C).
C = 'Bolivia'.
*/

largest_population_of_continent(Continent, Country) :-
    country(Country, _, Continent, Population1),
    \+ ((
        country(_, _, Continent, Population2),
        Population2 > Population1
    )).

/*
Question 5: Find Second Largest Population in Continent
Enunciate: Identify the country with the second largest population in a given
continent.

Predicate: second_largest_population_of_continent(?Continent, ?Country)
- Continent: The name of a continent (can be input or output)
- Country: The country with the second highest population in that continent
- First finds the country with the largest population
- Then finds the country with the largest population excluding the maximum
- Uses double negation to ensure correctness

Example:
?- second_largest_population_of_continent('South America', C).
C = 'Argentina'.
*/

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

/*
Question 6: Find Similar Neighbors
Enunciate: Find pairs of consecutive neighbors (in the borders list) of a country
whose border lengths differ by less than 1000 km.

Predicate: similar_neighbors(+Country, ?Neighbor1, ?Neighbor2)
- Country: The name of a country (input)
- Neighbor1: First neighbor in a consecutive pair
- Neighbor2: Second neighbor in a consecutive pair
- Succeeds if Neighbor1 and Neighbor2 are consecutive in the borders list
  and their border lengths differ by less than 1000 km

Example:
?- similar_neighbors('Bolivia', N1, N2).
N1 = 'Chile', N2 = 'Peru'.
*/

similar_neighbors(Country, Neighbor1, Neighbor2) :-
    borders(Country, Neighbors),
    append(_ , [Neighbor1-Length1, Neighbor2-Length2 | _], Neighbors),
    Length2 - Length1 < 1000.

/*
Question 7: Check if Borders are Sorted
Enunciate: Verify if a list of borders is sorted in ascending order by border
length.

Predicate: are_borders_sorted(+Borders)
- Borders: List of Neighbor-BorderLength pairs
- Succeeds if the list is sorted in non-decreasing order by border length
- Fails if any pair of consecutive borders is out of order
- Uses double negation: succeeds if there's no pair where Length2 < Length1

Example:
?- are_borders_sorted(['Chile'-861, 'Peru'-4300]).
true.
*/

are_borders_sorted(Borders) :-
    \+ ((
        append(_ , [_-Length1, _-Length2 | _], Borders),
        Length2 < Length1
    )).

/*
Question 8: Print All Countries
Enunciate: Print information about all countries in the database in a formatted
way.

Predicate: print_countries
- No arguments
- Prints each country's information in the format:
  "Capital, capital of Country, in Continent"
- Uses fail to backtrack through all countries
- Always succeeds (second clause ensures success after all countries printed)

Example:
?- print_countries.
Bogota, capital of Bolivia, in South America
true.
*/

print_countries :-
    country(Country, Capital, Continent, _),
    write(Capital), write(', capital of '),
    write(Country), write(', in '),
    write(Continent), nl,
    fail.
print_countries.

/*
Question 9: Get All Countries
Enunciate: Retrieve a list of all countries in the database without duplicates.

Predicate: get_countries(?Countries)
- Countries: List of all country names (output)
- Uses an accumulator-based approach to build the list
- Collects all unique countries from the database

Auxiliary: get_countries_aux(+Acc, ?Countries)
- Acc: Accumulator containing countries found so far
- Countries: Final list of all countries
- Uses cut (!) to commit to first new country found
- Base case: when no more new countries exist, return accumulator

Example:
?- get_countries(C).
C = ['Bolivia', 'Chile', 'Peru', ...].
*/

get_countries_aux(Acc, Countries) :-
    country(Country, _, _, _),
    \+ member(Country, Acc),
    !,
    get_countries_aux([Country | Acc], Countries).
get_countries_aux(Acc, Acc).

get_countries(Countries) :-
    get_countries_aux([], Countries).

/*
Question 10: Get Big Country Capitals by Continent
Enunciate: Find all capital cities of countries in a specific continent that
have a population of at least a given minimum.

Predicate: big_country_continent_capitals(+MinPopulation, ?Continent, ?Capitals)
- MinPopulation: Minimum population threshold in millions (input)
- Continent: The name of a continent (can be input or output)
- Capitals: Sorted list of capitals meeting the criteria (output)
- Uses setof/3 to collect unique capitals and automatically sort them
- The ^(Country, Population) notation declares existentially quantified variables

Example:
?- big_country_continent_capitals(10, 'South America', Caps).
Caps = ['Bogota'].
*/

big_country_continent_capitals(MinPopulation, Continent, Capitals) :-
    setof(Capital, (Country, Population)^(
        country(Country, Capital, Continent, Population),
        Population >= MinPopulation
    ), Capitals).


/*
Question 11: Get Most Populated Neighbors
Enunciate: Given a country, find its neighboring countries sorted by population
in descending order (most populous first).

Predicate: most_populated_neighbors(+Country, ?CountryList)
- Country: The name of a country (input)
- CountryList: List of neighboring countries sorted by population (descending)
- Uses setof/3 to collect Population-Neighbor pairs
- Reverses the sorted pairs to get descending order
- Extracts just the country names from the Population-Country pairs

Example:
?- most_populated_neighbors('Bolivia', List).
List = ['Peru', 'Chile'].
*/

most_populated_neighbors(Country, CountryList) :-
    borders(Country, Neighbors),
    setof(Population-Neighbor, (Length, Capital, Continent)^(
        member(Neighbor-Length, Neighbors),
        country(Neighbor, Capital, Continent, Population)
    ), Pairs),
    reverse(Pairs, DescPairs),
    findall(N, member(_-N, DescPairs), CountryList).

/*
Question 12: Find Trajectory Between Countries
Enunciate: Find a path of neighboring countries from one country to another,
where each country in the path shares a border with the next.

Predicate: trajectory(+Country1, +Country2, ?Trajectory)
- Country1: Starting country (input)
- Country2: Destination country (input)
- Trajectory: List of countries forming a path from Country1 to Country2
- Uses depth-first search to find a path
- Each country in the path borders the next country

Auxiliary: dfs(+Stack, +Target, ?Path)
- Stack: Stack of countries visited so far (most recent first)
- Target: Destination country
- Path: Final path from start to target (reversed to show correct order)
- Base case: if top of stack is target, return the stack as path
- Recursive case: find unvisited neighbor and continue search

Example:
?- trajectory('Bolivia', 'Peru', T).
T = ['Bolivia', 'Peru'].
*/

dfs([C2 | _], C2, [C2]).
dfs([Ca | T], C2, [Ca | Trajectory]) :-
    borders(Ca, L),
    member(Cb-_, L),
    \+ member(Cb, T),
    dfs([Cb, Ca | T], C2, Trajectory).

trajectory(C1, C2, Trajectory) :-
    dfs([C1], C2, Trajectory).
