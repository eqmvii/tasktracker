defmodule Tasktracker.Repo.Migrations.DeleteAllTododosOnUserDelete do
  use Ecto.Migration
    
  # thx stack overflow
  def up do
    execute "ALTER TABLE todos DROP CONSTRAINT todos_user_id_fkey"
    alter table(:todos) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end
  end

  def down do
    execute "ALTER TABLE todos DROP CONSTRAINT todos_user_id_fkey"
    alter table(:todos) do
      modify :user_id, references(:users, on_delete: :nothing)
    end
  end

end

