defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TasktrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/todos", TodoController
    resources "/users", UserController
    resources "/sitesession", SitesessionController, only: [:new, :index]
    post "/sitesession/test", SitesessionController, :test
  end

  # Other scopes may use custom stacks.
  # scope "/api", TasktrackerWeb do
  #   pipe_through :api
  # end
end
