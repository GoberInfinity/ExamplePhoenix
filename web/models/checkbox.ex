defmodule Otherpool.Checkbox do
  use Otherpool.Web, :model

  schema "checkboxes" do
    field :description, :string
    field :checked, :boolean, default: false
    belongs_to :list, Otherpool.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :checked])
    |> validate_required([:description, :checked])
  end
end
