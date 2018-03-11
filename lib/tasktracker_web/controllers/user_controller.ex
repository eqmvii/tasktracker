defmodule TasktrackerWeb.UserController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User

  plug :authenticate_user when action not in [:new, :create]

  def index(conn, _params) do
    users = Accounts.list_users()
    logged_in_user_name = get_session(conn, :logged_in_as)
    render(conn, "index.html", users: users, logged_in_user_name: logged_in_user_name)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  # TODO: Refactor this
  def create(conn, %{"user" => user_params}) do
    # TODO: Ensure uniqueness, i.e. have an error if account already exists
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:logged_in_as, user.name)
        |> put_session(:user_id, user.id)
        |> put_session(:logged_in, true)
        |> put_flash(:info, "Registration succesful!")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    my_id = get_session(conn, :user_id)
    
    if (id == Integer.to_string(my_id)) do
      conn
      |> put_flash(:error, "Can't delete your own account.")
      |> redirect(to: user_path(conn, :index))
      |> halt()
    else 
      user = Accounts.get_user!(id)
      {:ok, _user} = Accounts.delete_user(user)
      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: user_path(conn, :index))
    end

  end
end
