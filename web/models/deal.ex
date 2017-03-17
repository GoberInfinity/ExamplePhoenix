defmodule Otherpool.Deal do
  use Otherpool.Web, :model

  schema "dealers" do
    field :stock, :integer
    belongs_to :user, Otherpool.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:stock,:user_id])
    |> validate_required([:stock])
  end
end
