defmodule Otherpool.DummyTest do
  use Otherpool.ModelCase

  alias Otherpool.Dummy

  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Dummy.changeset(%Dummy{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Dummy.changeset(%Dummy{}, @invalid_attrs)
    refute changeset.valid?
  end
end
