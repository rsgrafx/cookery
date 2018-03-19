defmodule Cookery.Recipes.ApiTest do
  use ExUnit.Case
  use Plug.Test

  import Cookery.TestHelpers

  describe "Search HTTP interface" do

    setup do
      bypass = Bypass.open(port: 4022)
      {:ok, bypass: bypass}
    end

    test "/api/search/:food_item adheres to general structure", %{bypass: bypass} do
      call_bypass(bypass)

      assert {:ok,
        %{body: data}
      } = HTTPoison.get("http://localhost:4001/api/search/peanuts")

      data = Poison.decode!(data)

      assert %{
        "results" => _
      } = data
    end

    test "\nGET /api/search/:food_item \n returns list of Maps with specific data structure",
      %{bypass: bypass}
    do
      call_bypass(bypass)

      assert {:ok,
        %{body: data}
      } = HTTPoison.get("http://localhost:4001/api/search/peanuts")

      %{"results" => results} = Poison.decode!(data)

      assert [%{"ingredients" => _, "recipe_id" => _, "title" => _}|_] = results
    end

  end
end