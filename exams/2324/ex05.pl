% dish(Name, Price, IngredientGrams).
dish(pizza, 2200, [cheese-300, tomato-350]).
dish(ratatouille, 2200, [tomato-70, eggplant-150, garlic-50]).
dish(garlic_bread, 1600, [cheese-50, garlic-200]).

:- dynamic ingredient/2.

% ingredient(Name, CostPerGram).
ingredient(cheese, 4).
ingredient(tomato, 2).
ingredient(eggplant, 7).
ingredient(garlic, 6).

/* Implement most_expensive_dish(?Dish, ?Price), which determines the most expensive dish one can eat at the restaurant and its price.
In case of a tie, the predicate must return, via backtracking, each of the most expensive dishes. */

most_expensive_dish(Dish, Price) :-
    dish(Dish, Price, _),
    \+ (dish(_, Price1, _), Price1 > Price).
