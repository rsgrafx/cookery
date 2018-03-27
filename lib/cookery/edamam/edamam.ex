defmodule Cookery.Edamam do
  @moduledoc """
  House functionality that that builds URL specfic to Edamam API
  """

  def base_endpoint do
    [
      api_app_id: app_id,
      api_secret_key: app_secret_key,
      api_url: base_url
    ] = Application.get_env(:cookery, :edamam)

    "#{base_url}/search?app_id=#{app_id}&app_key=#{app_secret_key}"
  end

  def fetch_by_id_endpoint(uuid) do
    recipe_id =
     "http://www.edamam.com/ontologies/edamam.owl%23recipe_" <> uuid
    base_endpoint() <> "&r=#{recipe_id}"
  end

  def search_url(food_item) do
    base_endpoint() <> "&q=#{food_item}"
  end

end