# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shortener,
  ecto_repos: [Shortener.Repo]

# Configures the endpoint
config :shortener, ShortenerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Nhr/ywfuA1Qx6/EIl/KwGSUZrP8RtbryBfuEzbbrvee0TfCRHUDbeNezGdRvtsVh",
  render_errors: [view: ShortenerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Shortener.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configure your database
config :shortener, ShortenerWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
