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
