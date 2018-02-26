defmodule Tasktracker.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :name, :string
      add :number_of_pets, :integer

      timestamps()
    end

  end
end
