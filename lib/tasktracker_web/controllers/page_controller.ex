defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    admins = Tasktracker.Admin.list_admins()
    todos = ["Laundry", "sitting around", "learn elixir, phoenix, ruby, and rails"]
    render conn, "index.html", admins: admins, todos: todos
  end
end
