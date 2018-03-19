defmodule Cookery.Web.ApiRouter do
  import Plug.Conn

  use Plug.Router

  plug :match
  plug :dispatch
  plug :fetch_query_params

  get "/api/search/:food_item" do
    data = %{results: search(food_item)}
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Poison.encode!(data))
  end

  defp search(food_item) do
    Cookery.Recipes.Search.find_with_term(food_item)
  end

end