defmodule Cookery.Recipes.Search do
  @moduledoc """
  This houses the functionality that searches for desired recipes with a food term.
  """

  alias Cookery.Recipes
  alias Cookery.Edamam

  def find_with_term(food_item) do
    %{body: body} = search_recipes(food_item)
    body
    |> Poison.decode()
    |> return_recipes()
  end

  def fetch_by_id(recipe_id) do
    recipe_id
    |> Edamam.fetch_by_id_endpoint()
    |> HTTPoison.get!()
    |> case do
      %{status_code: 200, body: body} ->
        body
        |> Poison.decode()
        |> return_recipes()

      _ -> return_recipes(:null)
    end
  end

  def return_recipes({:ok, %{"hits" => recipes}}) do
    Recipes.transform_to_recipes(recipes)
  end

  def return_recipes({:ok, [%{"uri" => _recipes_url} = recipe]}) do
    Recipes.build_recipe(%{"recipe" => recipe})
  end

  def return_recipes(_),
    do: %{error: "Could not parse internal data", status_code: 422}

  def search_recipes(food_item) do
    food_item
    |> Edamam.search_url()
    |> HTTPoison.get!()
  end

  def stubbed_default() do
    find_with_term("peanuts")
  end

end