defmodule CookeryWeb.Resolvers.Recipe do
  @moduledoc """
  Resolve Recipe Search queries
  """
  alias Cookery.Recipe

  def fetch_recipe(_, %{recipe_id: recipe_id}, _) do
    {:ok, Cookery.Recipes.Search.fetch_by_id(recipe_id)}
  end

  def filter_recipes(_, %{matching: name}, _) do
    {:ok, Cookery.Recipes.Search.find_with_term(name)}
  end

  def filter_recipes(_, _, _) do
    {:ok, Recipe.all()}
  end

end