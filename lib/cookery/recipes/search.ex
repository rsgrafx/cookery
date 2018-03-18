defmodule Cookery.Recipes.Search do
  @moduledoc """
  This houses the functionality that searches for desired recipes with a food term.
  """

  def find_with_term(food_item) do
    %{body: body} = search_recipes(food_item)
    body
    |> Poison.decode()
    |> return_recipes()
  end

  def return_recipes({:ok, %{"hits" => recipes}}) do
    Enum.map(recipes, fn recipe ->
      build_recipe(recipe)
    end)
  end

  def return_recipes(_), do: {:error, "Could not parse internal data"}

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

  def search_recipes(food_item) do
    food_item
    |> build_url()
    |> HTTPoison.get!()
  end

  defp build_url(food_item) do
    app_id = Application.get_env(:cookery, :api_app_id)
    app_key = Application.get_env(:cookery, :api_secret_key)
    base_url = Application.get_env(:cookery, :api_url)
    "#{base_url}/search?q=#{food_item}&app_id=#{app_id}&app_key=#{app_key}"
  end
end