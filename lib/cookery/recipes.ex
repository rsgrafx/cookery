defmodule Cookery.Recipes do
  @moduledoc """
  House functionality that acts on multiple recipes - Base API.
  """

  def transform_to_recipes(recipes) do
    Enum.map(recipes, fn recipe ->
      build_recipe(recipe)
    end)
  end

  def build_recipe(%{"recipe" => %{
    "label" => title,
    "ingredients" => ingredient_list,
    "uri" => uri
    }
  }) do
    struct(Cookery.Recipe,
    title: title,
    ingredients: build_ingredients(ingredient_list),
    recipe_id: fetch_id(uri)
    )
  end

  def build_ingredients(list) do
    Enum.map(list, &ingredient/1)
  end
  def build_ingredients(_), do: []

  defp ingredient(%{"text" => text, "weight" => weight}) do
    struct(Cookery.Ingredient, weight: weight, text: text)
  end

  defp fetch_id("http://www.edamam.com/ontologies/edamam.owl#recipe_" <> uuid),
    do: uuid

end