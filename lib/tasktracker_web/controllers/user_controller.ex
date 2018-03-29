defmodule TasktrackerWeb.UserController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User

  plug :authenticate_user when action not in [:new, :create]

  def index(conn, _params) do
    users = Accounts.list_users()
    logged_in_user_name = get_session(conn, :logged_in_as)
    connections = Accounts.list_connections()
    render(conn, "index.html", users: users, logged_in_user_name: logged_in_user_name, connections: connections)
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
        conn
        |> put_flash(:error, "Error creating user")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def me(conn, _) do
    my_id = get_session(conn, :user_id)
    user = Accounts.get_user!(my_id)
    render(conn, "me.html", user: user)
  end

  def connect(conn, %{"id" => id}) do
    my_id = get_session(conn, :user_id)
    user = Accounts.get_user!(my_id)

    # |> cast(attrs, [:user_one_id, :user_two_id, :status, :last_moving_user])

    connection_params = %{user_one_id: my_id, user_two_id: String.to_integer(id), status: 17, last_moving_user: 17}

    case Accounts.create_connection(connection_params) do
      {:ok, connection} ->
        conn
        |> put_flash(:info, "Connection creation succesful #{connection.status}!")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error creating connection")
    end

    # !! work on this make it work: pass my_id and this users id
    Accounts.am_i_connected_to_you(21,0)
    raise inspect connection_params, pretty: true, limit: 300000

    conn
      # |> put_flash(:info, "Your target id:")
      |> render("me.html", user: user)
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
