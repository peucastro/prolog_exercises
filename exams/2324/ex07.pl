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

ingredientgrams_to_ingredients_aux([], Acc, Acc).
ingredientgrams_to_ingredients_aux([I-_ | T], Acc, Ingredients) :- ingredientgrams_to_ingredients_aux(T, [I | Acc], Ingredients).

ingredientgrams_to_ingredients(IngredientGrams, Ingredients) :- ingredientgrams_to_ingredients_aux(IngredientGrams, [], Ingredients).

count_dishes_with_ingredient(Ingredient, N) :- count_dishes_with_ingredient_aux(Ingredient, 0, N).
