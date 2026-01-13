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

/* Implement dish_profit(?Dish, ?Profit), which determines the profit of selling a dish in the restaurant. A dish's profit is the difference between its price and the combined cost of its ingredients. */

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
