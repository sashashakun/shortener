defmodule Shortener.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :original_url, :string
      add :shortened_url, :string

      timestamps()
    end

  end
end
