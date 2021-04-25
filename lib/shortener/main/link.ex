defmodule Shortener.Main.Link do
  use Ecto.Schema
  import Ecto.Changeset


  schema "links" do
    field :original_url, :string
    field :shortened_url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:original_url, :shortened_url])
    |> validate_required([:original_url, :shortened_url])
  end
end
