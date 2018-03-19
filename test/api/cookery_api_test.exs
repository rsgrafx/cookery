defmodule Cookery.Recipes.ApiTest do
  use ExUnit.Case
  use Plug.Test

  describe "Search HTTP interface" do
    test "/api/search/:food_item" do
      assert {:ok,
        %{body: data}
      } = HTTPoison.get("http://localhost:4001/api/search/foobar")

      assert %{
        "results" => _
      } = Poison.decode!(data)
    end
  end
end