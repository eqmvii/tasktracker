defmodule Tasktracker.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Admin


  schema "admins" do
    field :name, :string
    field :number_of_pets, :integer

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:name, :number_of_pets])
    |> validate_required([:name, :number_of_pets])
  end
end
