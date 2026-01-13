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

/*
Implement most_lucrative_dishes(?Dishes), which returns the restaurant's dishes, sorted by decreasing amount of profit. In case of a tie, any order of the tied dishes will be accepted.
Example:
| ?- most_lucrative_dishes(L).
L = [ratatouille,pizza,garlic_bread] ? ;
no
*/

:- use_module(library(lists)).

ingredient_amount_cost(Ingredient, Grams, TotalCost) :-
    ingredient(Ingredient, CostPerGram),
    TotalCost is Grams * CostPerGram.

dish_cost_aux([], Acc, Acc).
dish_cost_aux([Ingredient-Grams | Xs], Acc, Cost) :-
    ingredient_amount_cost(Ingredient, Grams, TotalCost),
    Acc1 is Acc + TotalCost,
    dish_cost_aux(Xs, Acc1, Cost).

dish_cost(IngredientGrams, Cost) :- dish_cost_aux(IngredientGrams, 0, Cost).

dish_profit(Dish, Profit) :-
    dish(Dish, Price, IngredientGrams),
    dish_cost(IngredientGrams, Cost),
    Profit is Price - Cost.

extract_names([], []).
extract_names([_-Dish | T], [Dish | Dishes]) :-
    extract_names(T, Dishes).

most_lucrative_dishes(Dishes) :-
    setof(Profit-Dish, (
        dish_profit(Dish, Profit)
    ), SortedPairs),
    reverse(SortedPairs, DescendingPairs),
    extract_names(DescendingPairs, Dishes).
