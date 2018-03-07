defmodule TasktrackerWeb.SitesessionController do
    use TasktrackerWeb, :controller
  
    # alias Tasktracker.Accounts
    # alias Tasktracker.Accounts.User

    # noodles should probably be _params
    def index(conn, noodles) do
        IO.puts "!!!!!!!!!!!!!!! Params to sitesession_controller !!!!!!!!!!!!!!"
        IO.puts inspect noodles
        IO.puts "conn.assigns: "
        IO.puts inspect conn.assigns
        IO.puts "___________________________"
        render conn, "index.html"
    end

    def new(conn, _params) do
        # changeset = Accounts.change_user(%User{})
        render(conn, "new.html")
    end

    # This will render the top to-do as whatever the user put into their form
    def test(conn, form_data) do
        IO.puts "******************* Params from form submission ******************* "
        IO.puts inspect form_data["name"]
        IO.puts "conn.assigns: "
        IO.puts inspect conn.assigns
        IO.puts " ******************* End for submission ******************* "
        conn = assign(conn, :name, form_data["name"])
        IO.puts "conn.assigns: "
        IO.puts inspect conn.assigns    
        put_flash(conn, :info, "SUBMITO!")
        admins = Tasktracker.Admin.list_admins()
        todos = [form_data["name"], "Laundry", "sitting around", "learn elixir, phoenix, ruby, and rails"]
        # redirect(conn, to: page_path(conn, :index), name: "EDWARD")    
        render conn, TasktrackerWeb.PageView, :index, admins: admins, todos: todos
    end

end