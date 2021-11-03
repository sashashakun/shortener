use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shortener, ShortenerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :debug

# Configure your database
config :shortener, Shortener.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "password",
  database: "shortener_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
