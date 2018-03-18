# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :cookery, [
  api_app_id: System.get_env("COOKERY_APP_ID"),
  api_secret_key: System.get_env("COOKERY_API_KEY"),
  api_url: "https://api.edamam.com"
]

import_config "#{Mix.env}.exs"
