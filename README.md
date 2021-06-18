# Reciplease

## General description

Reciplease allows you to search for recipes based on ingredients.
You can also keep your favorite recipes as favorites.
The application is therefore divided into two parts: research and
favorites. You can navigate between the two parts thanks to a bar
tabs ("Tab bar").

## Research

Here's how the research looks:

<img width="594" alt="Capture d’écran 2021-06-18 à 10 18 37" src="https://user-images.githubusercontent.com/57671772/122530329-a9b8f800-d01e-11eb-8aa4-db0c136687c2.png">


### The user chooses his ingredients:

* A text field allows him to add his ingredients one by one
after the others.
* Pressing the "Add" button adds an ingredient to the list.
* Pressing the "Clear" button deletes all the ingredients from the
listing.
* Pressing the "Search for recipes" button starts the search for
recipes.

### The search results are displayed in a view table
Each item in the list contains at least:
* The title of the recipe
* The image, if it is present (set a default image otherwise)
* The list of ingredients
* The execution time of the recipe, if present
* The note, if present

By selecting an item from the list, the user accesses the detail of
this recipe.

### The detail of the recipe
The recipe detail page must contain at least:
* The title of the recipe
* The complete list of ingredients with details of the portions
* The image, if it is present (set a default image otherwise)
* The execution time of the recipe, if present
* The note, if present
* A button to access the detailed list of instructions

On this page, a button allows you to save the recipe in its
favorites.

## Favorites
Here's how the favorites look:

<img width="525" alt="Capture d’écran 2021-06-18 à 10 18 51" src="https://user-images.githubusercontent.com/57671772/122530367-b0e00600-d01e-11eb-8d11-695dac230af1.png">


The interfaces are very similar to the search section. The only ones
differences are:

* The list is only made up of favorites (obviously!)
* If the list is empty, leave a message to the user for them
explain how to fill it.
* In the detail view, the button to bookmark is
selected. If the user taps it again, the recipe will not
is no longer a favorite.
