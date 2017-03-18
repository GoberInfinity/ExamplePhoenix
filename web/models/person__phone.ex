defmodule Otherpool.Person_Phone do
  use Otherpool.Web, :model

  schema "person_phones" do
    field :phone_number, :integer
    belongs_to :person, Otherpool.Person

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:phone_number])
    |> validate_required([:phone_number])
  end
end
