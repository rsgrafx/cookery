defmodule CookeryWeb.ApiRouter do

  import Plug.Conn
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Poison

  plug Absinthe.Plug,
    schema: CookeryWeb.GraphQL.Schema

  forward "/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: CookeryWeb.GraphQL.Schema,
      interface: :simple
    ]

  forward "/api",
    to: Absinthe.Plug,
    init_opts: [
      schema: CookeryWeb.GraphQL.Schema
    ]
end