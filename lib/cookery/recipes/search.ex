defmodule Cookery.Recipes.Search do
  @moduledoc """
  This houses the functionality that searches for desired recipes with a food term.
  """

  alias Cookery.Recipes

  def find_with_term(food_item) do
    %{body: body} = search_recipes(food_item)
    body
    |> Poison.decode()
    |> return_recipes()
  end

  def return_recipes({:ok, %{"hits" => recipes}}) do
    Recipes.transform_to_recipes(recipes)
  end

  def return_recipes(_), do: {:error, "Could not parse internal data"}

  def search_recipes(food_item) do
    food_item
    |> build_url()
    |> HTTPoison.get!()
  end

  defp build_url(food_item) do
    [
      api_app_id: app_id,
      api_secret_key: app_secret_key,
      api_url: base_url
    ] = Application.get_env(:cookery, :edamam)

    "#{base_url}/search?q=#{food_item}&app_id=#{app_id}&app_key=#{app_secret_key}"
  end
end