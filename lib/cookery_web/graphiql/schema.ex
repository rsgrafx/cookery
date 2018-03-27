defmodule CookeryWeb.GraphQL.Schema do
  use Absinthe.Schema

  alias Cookery.Recipe
  alias CookeryWeb.Resolvers

  query do
    @desc "List all Recipes for Food Item"
    field :recipes, list_of(:recipe) do
      arg :matching, :string
      resolve &Resolvers.Recipe.filter_recipes/3
    end

    @desc "Fetch Recipe by UUID"
    field :recipe, :recipe do
      arg :recipe_id, :string
      resolve &Resolvers.Recipe.fetch_recipe/3
    end
  end

  object :recipe do
    field :title, :string
    field :recipe_id, :string
    field :ingredients, list_of(:ingredient)
  end

  object :ingredient do
    field :text, :string
    field :weight, :float
  end

end