defmodule :"Elixir.Shortener.Repo.Migrations.Add-link-live-time" do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :live_time, :integer
    end
  end
end
