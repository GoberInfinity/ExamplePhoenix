defmodule Otherpool.CheckboxTest do
  use Otherpool.ModelCase

  alias Otherpool.Checkbox

  @valid_attrs %{checked: true, description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Checkbox.changeset(%Checkbox{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Checkbox.changeset(%Checkbox{}, @invalid_attrs)
    refute changeset.valid?
  end
end
