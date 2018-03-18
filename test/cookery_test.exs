defmodule CookeryTest do
  use ExUnit.Case

  describe "Search" do

    setup do
      bypass = Bypass.open(port: 4022)
      {:ok, bypass: bypass}
    end

    test "should return a list of recipes", %{bypass: bypass} do
      call_bypass(bypass)
      assert [%Cookery.Recipe{}|_] =
        Cookery.Recipes.Search.find_with_term("peanuts")
    end

    test "should make GET request to Edamam API with search term", %{bypass: bypass} do
      call_bypass(bypass)
      response = Cookery.Recipes.Search.search_recipes("peanuts")
      assert is_map response
      assert response.body =~ "hits"
    end
  end

  describe "Save" do
    test "should store recipe" do
      user_id = "user-pre-gen-uuid-1"
      assert is_map Cookery.Recipes.Save.store_recipe(user_id, recipe_data("recipe-pre-gen-uuid-1"))
    end

    test "stored data map structure" do
      user_id = "user-pre-gen-uuid-1"
      %{
        "user-pre-gen-uuid-1" => %{
          "recipes" => [%{recipe_id: "recipe-pre-gen-uuid-1"}|_]
        }
      } = Cookery.Recipes.Save.store_recipe(user_id, recipe_data("recipe-pre-gen-uuid-1"))
    end
  end

  def recipe_data(recipe_id) do
    struct(Cookery.Recipe,
        title: "Chicken Chop Suey",
        recipe_id: recipe_id
    )
  end

  def read_stub do
    {:ok, data} = File.read("test/fixtures/search_peanuts.json")
    data
  end

  def call_bypass(bypass) do
    Bypass.expect bypass, "GET", "/search", fn conn ->
      Plug.Conn.resp(conn, 200, read_stub() )
    end
  end

end
