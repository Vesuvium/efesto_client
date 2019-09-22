use Mix.Config

config :efesto_client,
  api_url: {:system, "API_URL", "http://localhost:5000"},
  api_token: {:system, "API_TOKEN", "token"}

import_config "#{Mix.env()}.exs"
