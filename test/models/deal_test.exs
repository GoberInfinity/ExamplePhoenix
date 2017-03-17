defmodule Otherpool.DealTest do
  use Otherpool.ModelCase

  alias Otherpool.Deal

  @valid_attrs %{stock: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Deal.changeset(%Deal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Deal.changeset(%Deal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
