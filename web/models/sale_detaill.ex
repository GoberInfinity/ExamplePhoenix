defmodule Otherpool.SaleDetaill do
  use Otherpool.Web, :model

  schema "sale_detaills" do
    field :order_date, Ecto.Date
    field :due_date, Ecto.Date
    field :subtotal, :integer
    belongs_to :sale_type, Otherpool.SaleType,foreign_key: :sale_type_id
    belongs_to :userp, Otherpool.Userp,foreign_key: :userp_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:order_date, :due_date, :subtotal,:sale_type_id,:userp_id])
    |> validate_required([:order_date, :due_date, :subtotal])
  end
end
