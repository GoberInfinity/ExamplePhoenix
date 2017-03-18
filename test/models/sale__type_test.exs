defmodule Otherpool.Sale_TypeTest do
  use Otherpool.ModelCase

  alias Otherpool.Sale_Type

  @valid_attrs %{name_sale: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sale_Type.changeset(%Sale_Type{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sale_Type.changeset(%Sale_Type{}, @invalid_attrs)
    refute changeset.valid?
  end
end
