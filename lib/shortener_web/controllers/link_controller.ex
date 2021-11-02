defmodule ShortenerWeb.LinkController do
  use ShortenerWeb, :controller

  alias Shortener.Main
  alias Shortener.Main.Link

  def index(conn, _params) do
    links = Main.list_links()
    render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = Main.change_link(%Link{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    case Main.create_link(link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: link_path(conn, :edit, link))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"key" => key}) do
    link = Main.get_link_by!(key)
    new_count = (link.views_count || 0) + 1
    case Main.update_link(link, %{ views_count: new_count }) do
      {:ok, link} ->
        redirect(conn, external: "http://#{link.original_url}");
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "something bad happened")
    end
  end

  def edit(conn, %{"id" => id}) do
    link = Main.get_link!(id)
    changeset = Main.change_link(link)
    render(conn, "edit.html", link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Main.get_link!(id)

    case Main.update_link(link, link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link updated successfully.")
        |> redirect(to: link_path(conn, :edit, link))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", link: link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Main.get_link!(id)
    {:ok, _link} = Main.delete_link(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: link_path(conn, :index))
  end
end
