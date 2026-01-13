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

/* Implement list_dishes(?DishIngredients), which returns a list of pairs Dish-ListOfIngredients. */

list_dishes(DishIngredients) :-
    findall(Dish-ListOfIngredients, (
        dish(Dish, _, ListOfIngredients)
    ), DishIngredients).
