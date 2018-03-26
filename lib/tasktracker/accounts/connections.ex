# TODO -- under construction

defmodule Tasktracker.Accounts.Connection do
    use Ecto.Schema
    import Ecto.Changeset
    alias Tasktracker.Accounts.User
    alias Tasktracker.Todos.Todo
    alias Tasktracker.Accounts.Connection


    schema "connections" do
        belongs_to :users_one, User, foreign_key: :user_one_id
        belongs_to :users_two, User, foreign_key: :user_two_id
        field :status, :integer
        field :last_moving_user, :integer

        timestamps()
    end

    # TODO - haven't touched this it's busted
    @doc false
    def changeset(%Connection{} = connection, attrs) do
        connection
            |> cast(attrs, [:user_one_id, :user_two_id, :status, :last_moving_user])
        # |> unique_constraint(:name) # somehow do both?
        # |> validate_required([:name, :age, :password])
    end
    end
  
# The migration that created this model-ish thing:

#   defmodule Tasktracker.Repo.Migrations.CreateConnectionsTable do
#     use Ecto.Migration
  
#     def change do
#       create table("connections") do
#         add :user_one_id, references(:users)
#         add :user_two_id, references(:users)
#         add :status, :integer
#         add :last_moving_user, :integer
  
#         timestamps()
#       end
#     end
#   end
  