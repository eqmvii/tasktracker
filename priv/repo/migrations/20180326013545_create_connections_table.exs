defmodule Tasktracker.Repo.Migrations.CreateConnectionsTable do
  use Ecto.Migration

  def change do
    create table("connections") do
      add :user_one_id, references(:users)
      add :user_two_id, references(:users)
      add :status, :integer
      add :last_moving_user, :integer

      timestamps()
    end
  end
end
