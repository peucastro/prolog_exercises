%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, paris, iberia, ib3444, 1640, 125).

/* a) Implement get_all_nodes(-ListOfAirports), which returns a list of all the airports served by the flights in the database, with no duplicates. */

get_all_nodes(ListOfAirports) :- setof(Airport,
                                      Origin^Destination^Company^Code^Hour^Duration^(
                                        flight(Airport, Destination, Company, Code, Hour, Duration);
                                        flight(Origin, Airport, Company, Code, Hour, Duration)
                                      ),
                                      ListOfAirports).

/* b) Implement most_diversified(-Company), which returns the company with the most diversified destinations,
i.e., largest number of cities it flies from/to (if more than one exist, new results should be returned via backtracking). */

:- use_module(library(lists)).

company_destinations(Company, Cities) :- setof(Target,
                                         Origin^Destination^Code^Hour^Duration^(
                                           flight(Target, Destination, Company, Code, Hour, Duration);
                                           flight(Origin, Target, Company, Code, Hour, Duration)
                                         ),
                                         Cities).

company_scores(Scores) :- setof(Score-Company,
                               Cities^(
                                 company_destinations(Company, Cities),
                                 length(Cities, Score)
                               ),
                               Scores).

most_diversified(Company) :- company_scores(Scores),
                             last(Scores, MaxScore-_),
                             member(MaxScore-Company, Scores).

/* c) Implement find_flights(+Origin, +Destination, -Flights), which returns in Flights a list with one or more flights (their codes) connecting Origin to Destination.
Use depth-first search, avoiding cycles. */

not(X) :- X, !, fail.
not(_).

find_flights_aux(Destination, Destination, _, []).
find_flights_aux(Origin, Destination, Visited, [Code | Tail]) :- flight(Origin, Neighbour, _, Code, _, _),
                                                                 not(memberchk(Neighbour, Visited)),
                                                                 find_flights_aux(Neighbour, Destination, [Neighbour | Visited], Tail).

find_flights(Origin, Destination, Flights) :- find_flights_aux(Origin, Destination, [Origin], Flights).

/* e) Implement find_all_flights (+Origin, +Destination, -ListOfFlights), which returns in ListOfFlights a list of all the possible ways to connect Origin to Destination (each represented as a list of flight codes). */

find_all_flights(Origin, Destination, ListOfFlights) :- setof(Flights, (find_flights(Origin, Destination, Flights)), ListOfFlights).

/* f) Implement find_flights_least_stops(+Origin, +Destination, -ListOfFlights), which returns in ListOfFlights a list of all possible ways to connect Origin to Destination
(each represented as a list of flight codes) with a minimum number of stops, i.e. a list of the shortest paths between Origin and Destination. */

find_all_flights_with_stops(Origin, Destination, ListWithStops) :- findall(Stops-Flights, (
                                                                          find_flights(Origin, Destination, Flights),
                                                                          length(Flights, L),
                                                                          Stops is L - 1
                                                                          ), UnsortedListWithStops),
                                                                   sort(UnsortedListWithStops, ListWithStops).

find_flights_least_stops(Origin, Destination, LeastStopsFlights) :- find_all_flights_with_stops(Origin, Destination, ListWithStops),
                                                                    ListWithStops = [MinStops-_ | _],
                                                                    findall(F, member(MinStops-F, ListWithStops), LeastStopsFlights).

/* h) Implement find_circular_trip (+MaxSize, +Origin, -Cycle), which returns in Cycle a list, of maximum length MaxSize, with flights that start and end in Origin, forming a cycle. */

find_circular_trip(MaxSize, Origin, ListOfCycles) :-
    findall(
        OneCycle,
        (
            flight(Origin, Neighbour, _, FirstCode, _, _),
            find_flights(Neighbour, Origin, Rest),
            OneCycle = [FirstCode | Rest],
            length(OneCycle, L),
            L =< MaxSize
        ),
        AllCycles),
    sort(AllCycles, ListOfCycles).
