defmodule ShortenerWeb.PageController do
  use ShortenerWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
