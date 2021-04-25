defmodule Shortener.MainTest do
  use Shortener.DataCase

  alias Shortener.Main

  describe "links" do
    alias Shortener.Main.Link

    @valid_attrs %{original_url: "some original_url", shortened_url: "some shortened_url"}
    @update_attrs %{original_url: "some updated original_url", shortened_url: "some updated shortened_url"}
    @invalid_attrs %{original_url: nil, shortened_url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Main.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Main.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Main.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Main.create_link(@valid_attrs)
      assert link.original_url == "some original_url"
      assert link.shortened_url == "some shortened_url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Main.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, link} = Main.update_link(link, @update_attrs)
      assert %Link{} = link
      assert link.original_url == "some updated original_url"
      assert link.shortened_url == "some updated shortened_url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Main.update_link(link, @invalid_attrs)
      assert link == Main.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Main.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Main.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Main.change_link(link)
    end
  end
end
