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

ingredientgrams_to_ingredients([], []).
ingredientgrams_to_ingredients([I-_ | T], [I | Ingredients]) :-
    ingredientgrams_to_ingredients(T, Ingredients).

list_dishes(DishIngredients) :-
    findall(Dish-Ingredients, (
        dish(Dish, _, IngredientGrams),
        ingredientgrams_to_ingredients(IngredientGrams, Ingredients)
    ), DishIngredients).
