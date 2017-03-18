defmodule Otherpool.User_TypeTest do
  use Otherpool.ModelCase

  alias Otherpool.User_Type

  @valid_attrs %{name_type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User_Type.changeset(%User_Type{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User_Type.changeset(%User_Type{}, @invalid_attrs)
    refute changeset.valid?
  end
end
