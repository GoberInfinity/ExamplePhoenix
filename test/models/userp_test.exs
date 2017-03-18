defmodule Otherpool.UserpTest do
  use Otherpool.ModelCase

  alias Otherpool.Userp

  @valid_attrs %{password_hash: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Userp.changeset(%Userp{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Userp.changeset(%Userp{}, @invalid_attrs)
    refute changeset.valid?
  end
end
