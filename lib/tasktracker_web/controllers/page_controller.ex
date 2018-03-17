defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  plug :testplug

  def index(conn, _params) do
    admins = Tasktracker.Admin.list_admins()
    todos = ["Laundry", "learn elixir, phoenix, ruby, and rails"]
    logged_in_user_name = get_session(conn, :logged_in_as)
    render conn, "index.html", admins: admins, todos: todos, logged_in_user_name: logged_in_user_name
  end

  def blob(conn, _params) do
    json conn, %{name: "Eric 'from a JSON route' Mancini", JSON: true, test_list: [1, "a", 3]}
  end

  defp testplug(conn, _) do
    assign(conn, :page_plug, "Worked!")
  end 

end
