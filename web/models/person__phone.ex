defmodule Otherpool.Person_Phone do
  use Otherpool.Web, :model

  schema "person_phones" do
    field :phone_number, :integer
    belongs_to :person, Otherpool.Person, foreign_key: :person_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:phone_number,:person_id])
    |> validate_required([:phone_number])
  end
end
