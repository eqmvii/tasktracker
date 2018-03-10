defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    admins = Tasktracker.Admin.list_admins()
    todos = ["Laundry", "sitting around", "learn elixir, phoenix, ruby, and rails"]
    logged_in_user_name = get_session(conn, :logged_in_as)
    IO.puts "!!!!!!!!!!!!!!! SESSION DUMP: !!!!!!!!!!!!!!!"
    IO.puts logged_in_user_name
    IO.puts "!!!!!!!!!!!!!!! SESSION DUMP: !!!!!!!!!!!!!!!"
    render conn, "index.html", admins: admins, todos: todos, logged_in_user_name: logged_in_user_name
  end
end
