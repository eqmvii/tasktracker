defmodule Tasktracker.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Task
  
  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  schema "tasks" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
  
  def list_tasks do
    Repo.all(Task)
  end
end
