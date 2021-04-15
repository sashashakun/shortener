defmodule ShortenerWeb.Router do
  use ShortenerWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ShortenerWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShortenerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/url", UrlController, except: [:edit, :update]
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
  end

  scope "/api", ShortenerWeb do
    pipe_through :api
  end

  scope "/cms", ShortenerWeb.CMS, as: :cms do
    pipe_through [:browser, :authenticate_user]

    resources "/pages", PageController
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Shortener.Accounts.get_user!(user_id))
    end
  end
end

# Now, let's fire up the server with mix phx.server and visit http://localhost:4000/cms/pages. If we haven't logged in yet, we'll be redirected to the home page with a flash error message telling us to sign in. Let's sign in at http://localhost:4000/sessions/new, then re-visit http://localhost:4000/cms/pages. Now that we're authenticated, we should see a familiar resource listing for pages, with a New Page link.
