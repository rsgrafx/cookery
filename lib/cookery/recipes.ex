defmodule Cookery.Recipes do
  @moduledoc """
  House functionality that acts on multiple recipes - Base API.
  """

  def transform_to_recipes(recipes) do
    Enum.map(recipes, fn recipe ->
      build_recipe(recipe)
    end)
  end

  defp build_recipe(%{"recipe" => %{
    "label" => title,
    "ingredients" => ingredient_list,
    "uri" => uri
    }
  }) do
    struct(Cookery.Recipe,
    title: title,
    ingredients: ingredient_list,
    recipe_id: fetch_id(uri)
    )
  end

  defp fetch_id("http://www.edamam.com/ontologies/edamam.owl#recipe_" <> uuid),
    do: uuid

end