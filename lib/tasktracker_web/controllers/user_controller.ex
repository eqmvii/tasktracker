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
    my_id = get_session(conn, :user_id)
    your_id = String.to_integer(id)
    user = Accounts.get_user!(id)
    connected = 
      if Accounts.connection_status(my_id, your_id) > 1 do
        true
      else
        false
      end
    connection_status = Accounts.connection_status(my_id, your_id)
    render(conn, "show.html", user: user, connected: connected, connection_status: connection_status)
  end

  def me(conn, _) do
    my_id = get_session(conn, :user_id)
    user = Accounts.get_user!(my_id)
    render(conn, "me.html", user: user)
  end

  # # # # # # #

  def connectconfirm(conn, %{"id" => id}) do
    my_id = get_session(conn, :user_id)
    your_id = String.to_integer(id)
    user = Accounts.get_user!(my_id) # comment this out?


    conn
    |> redirect to: "/users/me"
  end

  def connectrequest(conn, %{"id" => id}) do
    my_id = get_session(conn, :user_id)
    your_id = String.to_integer(id)
    user = Accounts.get_user!(my_id) # comment this out?

    if my_id < your_id do
      user_one_id = my_id
      user_two_id = your_id
    else
      user_one_id = your_id
      user_two_id = my_id
    end

    connection_params = %{user_one_id: user_one_id, user_two_id: user_two_id, status: 1, last_moving_user: my_id}

    case Accounts.update_connection(connection_params) do
      {:ok, connection} ->
        conn
        |> put_flash(:info, "Connection request sent! Status: #{connection.status}!")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error creating connection")
    end

    conn
    |> redirect to: "/users/#{your_id}"
  end

  def connect(conn, %{"id" => id}) do
    my_id = get_session(conn, :user_id)
    your_id = String.to_integer(id)
    user = Accounts.get_user!(my_id) # comment this out?

    # |> cast(attrs, [:user_one_id, :user_two_id, :status, :last_moving_user])

    if my_id < your_id do
      user_one_id = my_id
      user_two_id = your_id
    else
      user_one_id = your_id
      user_two_id = my_id
    end

    connection_params = %{user_one_id: user_one_id, user_two_id: user_two_id, status: 100, last_moving_user: my_id}

    IO.puts "FIRST am_i_connected"
    hello = Accounts.am_i_connected_to_you(my_id, your_id)

    case Accounts.update_connection(connection_params) do
      {:ok, connection} ->
        conn
        |> put_flash(:info, "Connection update succesful #{connection.status}!")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error creating connection")
    end

    # !! work on this make it work: pass my_id and this users id
    IO.puts "SECOND am_i_connected"

    hello = Accounts.am_i_connected_to_you(my_id, id)
    # raise inspect connection_params, pretty: true, limit: 300000

    conn
      # |> put_flash(:info, "Your target id:")
      # |> render("me.html", user: user)
      |> redirect to: "/users/#{your_id}"
  end

  def clearconnections(conn, _) do
    Accounts.delete_all_connections()
    conn
      |> put_flash(:info, "Deleted all connections successfully.")
      |> redirect(to: user_path(conn, :index))
  end

  # # # # # # # # #

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
