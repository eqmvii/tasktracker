defmodule Tasktracker.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Todos.Todo


  schema "todos" do
    field :name, :string
    field :priority, :integer

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:name, :priority])
    |> validate_required([:name, :priority])
  end
end
