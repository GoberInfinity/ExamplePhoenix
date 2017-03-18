defmodule Otherpool.User_Type do
  use Otherpool.Web, :model

  schema "user_types" do
    field :name_type, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name_type])
    |> validate_required([:name_type])
  end
end
