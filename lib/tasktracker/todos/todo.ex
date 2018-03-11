defmodule Tasktracker.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Todos.Todo
  alias Tasktracker.Accounts.User


  schema "todos" do
    field :name, :string
    field :priority, :integer
    belongs_to :users, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:name, :priority, :user_id])
    |> validate_required([:name, :priority, :user_id])
  end
end

# TODO: Migrate this to belong to user