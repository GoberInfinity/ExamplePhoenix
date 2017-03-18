defmodule Otherpool.Sale do
  use Otherpool.Web, :model

  schema "sales" do
    field :order_date, Ecto.Date
    field :due_date, Ecto.Date
    field :subtotal, :integer 
    belongs_to :userp, Otherpool.Userp, foreign_key: :userps_id
    belongs_to :sale_type, Otherpool.SaleType

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:order_date, :due_date, :subtotal, :sale_type_id, :userp_id])
    |> validate_required([:order_date, :due_date, :subtotal])
  end
end
