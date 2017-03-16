defmodule Otherpool.DummyView do
  use Otherpool.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :age, :inserted_at, :updated_at]
  

end
