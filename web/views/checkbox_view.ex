defmodule Otherpool.CheckboxView do
  use Otherpool.Web, :view
  use JaSerializer.PhoenixView

  attributes [:description, :checked, :inserted_at, :updated_at]
  
  has_one :list,
    field: :list_id,
    type: "list"

end
