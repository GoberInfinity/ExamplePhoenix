defmodule Otherpool.Sale_Type do
  use Otherpool.Web, :model

  schema "sale_types" do
    field :name_sale, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name_sale])
    |> validate_required([:name_sale])
  end
end
