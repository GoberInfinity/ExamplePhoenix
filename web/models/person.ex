defmodule Otherpool.Person do
  use Otherpool.Web, :model

  schema "persons" do
    field :first_name, :string
    field :middle_name, :string
    field :last_name, :string
    field :email, :string
    field :age, :integer
    field :birthday, Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :middle_name, :last_name, :email, :age, :birthday])
    |> validate_required([:first_name, :middle_name, :last_name, :email, :age, :birthday])
  end
end
