pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(macLean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb, breitling).
team(besenyei, redbull).
team(chambliss, redbull).
team(macLean, mediterraneanracingteam).
team(mangold, cobra).
team(jones, matador).
team(bonhomme, matador).

drives(lamb, mx2).
drives(besenyei, edge540).
drives(chambliss, edge540).
drives(macLean, edge540).
drives(mangold, edge540).
drives(jones, edge540).
drives(bonhomme, edge540).

circuit(istanbul).
circuit(budapest).
circuit(porto).

winned(jones, porto).
winned(mangold, budapest).
winned(mangold, istanbul).

gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

team_winned(T, C) :- team(D, T), winned(D, C).

/* b) Write the following questions in Prolog:b) Write the following questions in Prolog: */

% Who won the race in Porto?
% winned(X, porto).

% What team won the race in Porto?
% winned(_X, porto), team(_X, Y).

% Which circuits have nine gates?
% gates(X, 9).

% Which pilots do not fly an Edge540?
% drives(X, _C), _C \= edge540.

% Which pilots have won more than one circuit?
winned(X, _C1), winned(X, _C2), _C1 \= _C2.
% winned(_D, porto), drives(_D, P).
