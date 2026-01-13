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

/* Implement count_dishes_with_ingredient(+Ingredient, ?N), which determines how many dishes use the given ingredient. */

count_dishes_with_ingredient(Ingredient, N) :-
    findall(Dish, (
        dish(Dish, _, IngredientGrams),
        memberchk(Ingredient-_, IngredientGrams)
    ), L),
    length(L, N).
