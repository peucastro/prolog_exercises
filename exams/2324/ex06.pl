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
Implement consume_ingredient(+IngredientStocks, +Ingredient, +Grams, ?NewIngredientStocks), which receives a list of ingredient stocks (as pairs of Ingredient-Amount), an ingredient, and an amount (in grams) and computes a new list obtained from removing the given amount of ingredient from the original stock.
The predicate must only succeed if there is enough ingredient in stock.
Constraint: In this question, and in this question only, you are not allowed to use recursion. Solutions using recursion will only receive up to 25% of the maximum score.
*/

consume_ingredient(IngredientStocks, Ingredient, Grams, NewIngredientStocks) :-
    append(Prefix, [Ingredient-OriginalGrams | Suffix], IngredientStocks),
    NewGrams is OriginalGrams - Grams, NewGrams >= 0,
    append(Prefix, [Ingredient-NewGrams | Suffix], NewIngredientStocks)
