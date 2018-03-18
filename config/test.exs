use Mix.Config

config :bypass,
  enable_debug_log: false

config :cookery, [
  api_app_id: System.get_env("COOKERY_APP_ID"),
  api_secret_key: System.get_env("COOKERY_API_KEY"),
  api_url: "http://localhost:4022"
]

