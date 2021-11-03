defmodule ShortenerWeb.LinkControllerTest do
  use ShortenerWeb.ConnCase

  alias Shortener.Main

  @create_attrs %{original_url: "some_original_url", shortened_url: "some_shortened_url"}
  @expired_attrs %{original_url: "some_original_url", shortened_url: "some_shortened_url", live_time: 0}
  @update_attrs %{original_url: "some_updated_original_url", shortened_url: "some_updated_shortened_url"}
  @invalid_attrs %{original_url: nil, shortened_url: nil}

  def fixture(:link) do
    {:ok, link} = Main.create_link(@create_attrs)
    link
  end

  def fixture_expired(:link) do
    {:ok, link} = Main.create_link(@expired_attrs)
    link
  end

  describe "index" do
    test "lists all links", %{conn: conn} do
      conn = get conn, link_path(conn, :index)
      assert html_response(conn, 200) =~ "Links"
    end
  end

  describe "new link" do
    test "renders form", %{conn: conn} do
      conn = get conn, link_path(conn, :new)
      assert html_response(conn, 200) =~ "New Link"
    end
  end

  describe "open link" do
    setup [:create_link]

    test "redirects to original url", %{conn: conn, link: link} do
      conn = get conn, link_path(conn, :show, link.shortened_url)
      assert redirected_to(conn) == "http://#{link.original_url}"
    end
  end

  describe "open expired link" do
    setup [:create_expired_link]

    test "does not redirect to original url", %{conn: conn, link: link} do
      conn = get conn, link_path(conn, :show, link.shortened_url)
      assert redirected_to(conn) == link_path(conn, :index)
    end
  end

  describe "create link" do
    test "redirects to edit when data is valid", %{conn: conn} do
      conn = post conn, link_path(conn, :create), link: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == link_path(conn, :edit, id)

      conn = get conn, link_path(conn, :edit, id)
      assert html_response(conn, 200) =~ "Link created successfully."
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, link_path(conn, :create), link: @invalid_attrs
      assert html_response(conn, 200) =~ "New Link"
    end
  end

  describe "edit link" do
    setup [:create_link]

    test "renders form for editing chosen link", %{conn: conn, link: link} do
      conn = get conn, link_path(conn, :edit, link)
      assert html_response(conn, 200) =~ "Edit Link"
    end
  end

  describe "update link" do
    setup [:create_link]

    test "redirects when data is valid", %{conn: conn, link: link} do
      conn = put conn, link_path(conn, :update, link), link: @update_attrs
      assert redirected_to(conn) == link_path(conn, :edit, link)

      conn = get conn, link_path(conn, :edit, link)
      assert html_response(conn, 200) =~ "Link updated successfully."
    end

    test "renders errors when data is invalid", %{conn: conn, link: link} do
      conn = put conn, link_path(conn, :update, link), link: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Link"
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      conn = delete conn, link_path(conn, :delete, link)
      assert redirected_to(conn) == link_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, link_path(conn, :show, link)
      end
    end
  end

  defp create_link(_) do
    link = fixture(:link)
    {:ok, link: link}
  end

  defp create_expired_link(_) do
    link = fixture_expired(:link)
    {:ok, link: link}
  end
end
