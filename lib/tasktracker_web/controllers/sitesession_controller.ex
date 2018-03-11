defmodule TasktrackerWeb.SitesessionController do
    use TasktrackerWeb, :controller

    alias Tasktracker.Repo
  
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
        # conn = assign(conn, :name, form_data["name"])
        # admins = Tasktracker.Admin.list_admins()
        # todos = [form_data["name"], "Laundry", "sitting around", "learn elixir, phoenix, ruby, and rails"]
        # redirect(conn, to: page_path(conn, :index), name: "EDWARD")
        # Shockingly the below code basically works, and can probably form the skeleton of an authentication scheme.
        # TODO: That
        is_a_user = Repo.get_by(Tasktracker.Accounts.User, name: form_data["name"])
        cond do
            is_a_user ->
                cond do
                    is_a_user.password == form_data["password"] ->
                        IO.puts " % % % % % % % % % LOG IN SUCCESS % % % % % % % % % "
                        conn = put_session(conn, :logged_in_as, form_data["name"])
                    true ->
                        conn = put_session(conn, :logged_in_as, "Guest (wrong password)")
                end
            true ->
                conn = put_session(conn, :logged_in_as, "Guest (wrong username)")
        end

        is_correct_password = Repo.get_by(Tasktracker.Accounts.User, password: form_data["password"])

        IO.puts "Did it work?"
        IO.puts inspect is_a_user
        IO.puts inspect is_correct_password
        IO.puts "You tell me!"
        # logged_in_user_name = get_session(conn, :logged_in_as)
        # render conn, TasktrackerWeb.PageView, :index, admins: admins, todos: todos, logged_in_user_name: logged_in_user_name
        redirect(conn, to: page_path(conn, :index))
    end

end