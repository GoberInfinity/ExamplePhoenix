defmodule Otherpool.User do
  use Otherpool.Web, :model

  schema "users" do
    field :fullname, :string
    field :email, :string
    has_many :dealers, Otherpool.Deal 
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:fullname, :email])
    |> validate_required([:fullname, :email])
  end
end
