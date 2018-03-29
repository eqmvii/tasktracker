defmodule Tasktracker.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Accounts.User
  alias Tasktracker.Accounts.Connection


  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  # ------------------------------------------------------
  # TODO: This is where I am. The connection data is getting inserted. Something weird is happening with redirect.
  def create_connection(attrs \\ %{}) do
    IO.puts " % % % % % % % % % % % %W OWOWLWOL % % % % % % % % % % % %W OWOWLWOL  "
    IO.puts " % % % % % % % % % % % %W OWOWLWOL % % % % % % % % % % % %W OWOWLWOL  "
    IO.puts " % % % % % % % % % % % %W OWOWLWOL % % % % % % % % % % % %W OWOWLWOL  "
    # IO.puts inspect attrs, pretty: true, limit: 30000
    # IO.puts inspect list_connections, pretty: true, limit: 30000
    IO.puts " % % % % % % % % % % % %W OWOWLWOL % % % % % % % % % % % %W OWOWLWOL  "
    IO.puts " % % % % % % % % % % % %W OWOWLWOL % % % % % % % % % % % %W OWOWLWOL  "
    IO.puts " % % % % % % % % % % % %W OWOWLWOL % % % % % % % % % % % %W OWOWLWOL  "

    %Connection{}
    |> Connection.changeset(attrs)
    |> Repo.insert()
  end

  def list_connections do
    Repo.all(Connection)
  end

  def am_i_connected_to_you(my_id, your_id) do
    # Repo.get!(User, id)

    # query = from c in "conections", where: c.user_one_id == my_id, select: u.name
    query = from c in Connection, select: count(c.id)
    raise inspect Repo.all(query), pretty: true, limit: 30000
    
  end
  # ------------------------------------------------------

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
