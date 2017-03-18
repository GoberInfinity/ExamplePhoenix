defmodule Otherpool.Userp do
  use Otherpool.Web, :model

  schema "userps" do
    field :password_hash, :string
    field :password, :string, virtual: true      
    belongs_to :person, Otherpool.Person, foreign_key: :person_id
    belongs_to :type, Otherpool.Type, foreign_key: :type_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:password_hash, :person_id,:type_id])
    |> validate_required([:password_hash])
  end
end
