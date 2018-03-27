defmodule CookeryWeb.Resolvers.Recipe do
  @moduledoc """
  Resolve Recipe Search queries
  """
  alias Cookery.Recipes.Search

  def fetch_recipe(_, %{recipe_id: recipe_id}, _) do
    {:ok, Search.fetch_by_id(recipe_id)}
  end

  def filter_recipes(_, %{matching: name}, _) do
    {:ok, Search.find_with_term(name)}
  end

  def filter_recipes(_, _, _) do
    {:ok, Search.stubbed_default()}
  end

end