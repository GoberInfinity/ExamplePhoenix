defmodule Otherpool.SaleDetaillTest do
  use Otherpool.ModelCase

  alias Otherpool.SaleDetaill

  @valid_attrs %{due_date: %{day: 17, month: 4, year: 2010}, order_date: %{day: 17, month: 4, year: 2010}, subtotal: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SaleDetaill.changeset(%SaleDetaill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SaleDetaill.changeset(%SaleDetaill{}, @invalid_attrs)
    refute changeset.valid?
  end
end
