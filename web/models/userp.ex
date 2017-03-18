defmodule Otherpool.Userp do
  use Otherpool.Web, :model

  schema "userps" do
    field :password_hash, :string
    belongs_to :person, Otherpool.Person
    belongs_to :type, Otherpool.Type

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:password_hash])
    |> validate_required([:password_hash])
  end
end
