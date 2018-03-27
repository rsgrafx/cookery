defmodule Cookery.Application do
  use Application

  def start(_type, _args) do
    port = Application.get_env(:cookery, :http_port)
    children = [
      {
        Plug.Adapters.Cowboy,
        scheme: :http,
        plug: CookeryWeb.ApiRouter,
        options: [port: port]
      },
      {
        Registry, [
          keys: :unique,
          name: :cookery_user_recipes
        ]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cookery.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
