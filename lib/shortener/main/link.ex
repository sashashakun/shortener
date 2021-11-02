defmodule Shortener.Main.Link do
  use Ecto.Schema
  import Ecto.Changeset


  schema "links" do
    field :original_url, :string
    field :shortened_url, :string
    field :views_count, :integer

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:original_url, :shortened_url, :views_count])
    |> validate_required([:original_url, :shortened_url])
    |> unique_constraint(:shortened_url, message: "such short url already exists", name: "links_shortened_url_index")
  end
end
