defmodule ShortenerWeb.PageControllerTest do
  use ShortenerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Listing Links"
  end
end
