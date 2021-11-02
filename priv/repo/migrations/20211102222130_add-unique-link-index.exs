defmodule :"Elixir.Shortener.Repo.Migrations.Add-unique-link-index" do
  use Ecto.Migration

  def change do
    create unique_index(:links, [:shortened_url])
  end
end
