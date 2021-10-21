defmodule :"Elixir.Shortener.Repo.Migrations.Add-links-view-counter" do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :views_count, :integer
    end

  end
end
