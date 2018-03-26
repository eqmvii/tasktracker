defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Todos.Todo
  alias Tasktracker.Accounts.Connection

  schema "users" do
    field :age, :integer
    field :name, :string
    field :password, :string
    has_many :connections, Connection
    has_many :todos, Todo

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :age, :password])
    |> unique_constraint(:name)
    |> validate_required([:name, :age, :password])
  end
end

# TODO: Migrate this to have-many todos