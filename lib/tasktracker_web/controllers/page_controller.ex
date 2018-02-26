defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    admins = Tasktracker.Admin.list_admins()
    render conn, "index.html", admins: admins
  end
end
