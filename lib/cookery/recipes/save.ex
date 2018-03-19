defmodule Cookery.Recipes.Save do
  @moduledoc """
  House functionality to save recipe data.
  """

  def store_recipe(user_uuid, new_recipe) do
    # Find user process if one exists.
    {:ok, user_process} =
      find_or_create_user(user_uuid)
      {:ok, _, recipes} = get_recipes(user_uuid)
      recipes = recipes ++ [new_recipe]
      Agent.update(user_process, fn(data) ->
        %{
          user_uuid =>
            %{recipes: recipes}
        }
      end)
  end

  def find_or_create_user(user_id) do
    case Registry.lookup(:cookery_user_recipes, user_id) do
      [] ->
        new(user_id)
      [{user_process, _}] ->
        {:ok, user_process}
    end
  end

  def get_recipes(user_id) do
    {:ok, user_process} = find_or_create_user(user_id)
    data = Agent.get(user_process, &(&1))
    {:ok, :recipes, data[user_id].recipes}
  end

  def new(user_uuid) do
    func = fn ->
      %{user_uuid => %{recipes: []}}
    end
    Agent.start_link(func,
    name: {:via, Registry, {:cookery_user_recipes, user_uuid}}
    )
  end

end