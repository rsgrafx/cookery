use Mix.Config

config :cookery, edamam: [
  api_app_id: System.get_env("COOKERY_APP_ID"),
  api_secret_key: System.get_env("COOKERY_API_KEY"),
  api_url: "https://api.edamam.com"
]
