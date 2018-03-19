defmodule CookeryTest do
  use ExUnit.Case
  import Cookery.TestHelpers

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
      assert :ok = Cookery.Recipes.Save.store_recipe(user_id, recipe_data("recipe-pre-gen-uuid-1"))
    end

    test "stored data map structure" do
      user_id = "user-pre-gen-uuid-1"
      Cookery.Recipes.Save.store_recipe(user_id, recipe_data("recipe-pre-gen-uuid-1"))
      assert {:ok, :recipes, [%{recipe_id: "recipe-pre-gen-uuid-1"}|_] }
        = Cookery.Recipes.Save.get_recipes user_id
    end
  end

  def recipe_data(recipe_id) do
    struct(Cookery.Recipe,
        title: "Chicken Chop Suey",
        recipe_id: recipe_id
    )
  end

end
