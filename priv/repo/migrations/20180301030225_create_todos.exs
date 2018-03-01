defmodule Tasktracker.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :name, :string
      add :priority, :integer

      timestamps()
    end

  end
end
