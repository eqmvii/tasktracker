defmodule Tasktracker.Repo.Migrations.ConnectUsersTodos do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add :user_id, :integer
    end


    alter table(:todos) do
      modify :user_id, references(:users)
    end
  end
end
