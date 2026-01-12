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

/* Implement count_ingredients(?Dish, ?NumIngredients), which determines how many different ingredients are needed to produce a dish. */

count_ingredients(Dish, NumIngredients) :-
    dish(Dish, _, Ingredients),
    length(Ingredients, NumIngredients).
