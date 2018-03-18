defmodule Cookery.Recipes.Search do
  @moduledoc """
  This houses the functionality that searches for desired recipes with a food term.
  """

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