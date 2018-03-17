defmodule CookeryTest do
  use ExUnit.Case

  describe "Search" do
    test "should return a list of recipes" do
      assert is_list(Cookery.Recipes.Search.find_with_term("peanuts"))
    end
  end
end
