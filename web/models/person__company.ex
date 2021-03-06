defmodule Otherpool.Person_Company do
  use Otherpool.Web, :model

  schema "person_companies" do
    field :name_company, :string
    belongs_to :person, Otherpool.Person, foreign_key: :person_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name_company,:person_id])
    |> validate_required([:name_company])
  end
end
