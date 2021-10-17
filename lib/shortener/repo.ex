defmodule Shortener.Repo do
  use Ecto.Repo, otp_app: :shortener, adapter: Ecto.Adapters.Postgres

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_type, config) do
    config = Keyword.put(config, :url, System.get_env("DATABASE_URL"))

    {:ok, config}
  end
end
