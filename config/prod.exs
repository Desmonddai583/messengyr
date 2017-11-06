use Mix.Config

config :messengyr, MessengyrWeb.Endpoint,
  load_from_system_env: true,
  url: [scheme: "https", host: "desmonddai583-messengyr.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :logger, level: :info

config :messengyr, Messengyr.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 20,
  ssl: true

config :guardian, Guardian,
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

config :phoenix, :serve_endpoints, true