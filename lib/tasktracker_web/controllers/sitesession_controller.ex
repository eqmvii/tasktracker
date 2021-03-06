defmodule TasktrackerWeb.SitesessionController do
    use TasktrackerWeb, :controller

    alias Tasktracker.Repo
  
    # alias Tasktracker.Accounts
    # alias Tasktracker.Accounts.User

    # noodles should probably be _params
    def index(conn, noodles) do
        render conn, "index.html"
    end

    def new(conn, _params) do
        # changeset = Accounts.change_user(%User{})
        render(conn, "new.html")
    end

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
                        conn = put_session(conn, :logged_in_as, form_data["name"])
                        conn = put_session(conn, :user_id, is_a_user.id)
                        conn = put_session(conn, :logged_in, true)
                    true ->
                        # conn = put_session(conn, :logged_in_as, "Guest (wrong password)")
                        conn = put_flash(conn, :error, "Wrong password")
                end
            true ->
                conn = put_flash(conn, :error, "Invalid username")
                # conn = put_session(conn, :logged_in_as, "Guest (wrong username)")
        end

        # is_correct_password = Repo.get_by(Tasktracker.Accounts.User, password: form_data["password"]
        # logged_in_user_name = get_session(conn, :logged_in_as)
        # render conn, TasktrackerWeb.PageView, :index, admins: admins, todos: todos, logged_in_user_name: logged_in_user_name
        redirect(conn, to: page_path(conn, :index))
    end

    def logout(conn, _) do
        conn = put_session(conn, :logged_in, false)
        conn = put_session(conn, :logged_in_as, nil)
        conn = put_session(conn, :user_id, nil)
        redirect(conn, to: page_path(conn, :index))
    end



end