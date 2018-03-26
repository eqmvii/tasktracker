defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :testplug
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session # added for authentication?
    plug :fetch_flash
  end

  scope "/", TasktrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/todos", TodoController
    get "/users/me", UserController, :me
    get "/users/connect/:id", UserController, :connect
    resources "/users", UserController    
    resources "/sitesession", SitesessionController, only: [:new, :index]
    post "/sitesession/test", SitesessionController, :test
    # get "/login", SiteSessionController, :login
    get "/logout", SitesessionController, :logout
  end

  # API
  scope "/api", TasktrackerWeb do
    pipe_through :api
    

    get "/", PageController, :blob
    # resources "/todos", TodoControllerApi
    get "/todos", TodoControllerApi, :index
    get "/todos/:id", TodoControllerApi, :show

  end
  
  # TODO: Move this plug somewhere thta like, it has any business being?
  defp testplug(conn, _) do
    # logged_in_user_name = get_session(conn, :logged_in_as)
    # IO.puts inspect logged_in_user_name
    case get_session(conn, :logged_in_as) do
      nil ->
        conn = assign(conn, :logged_in, false)
        conn = assign(conn, :plugtest, "")
      anything ->
        conn = assign(conn, :plugtest, anything)
        conn = assign(conn, :logged_in, true)
      true ->
        IO.puts "no idea"
        conn = assign(conn, :plugtest, "WOLOLOLOLO weird error")
        conn = assign(conn, :logged_in, "walrus")
    end
    conn
  end 

  # Other scopes may use custom stacks.
  # scope "/api", TasktrackerWeb do
  #   pipe_through :api
  # end
end
