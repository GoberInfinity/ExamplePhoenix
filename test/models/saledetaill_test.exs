defmodule Otherpool.SaledetaillTest do
  use Otherpool.ModelCase

  alias Otherpool.Saledetaill

  @valid_attrs %{due_date: %{day: 17, month: 4, year: 2010}, order_date: %{day: 17, month: 4, year: 2010}, subtotal: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Saledetaill.changeset(%Saledetaill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Saledetaill.changeset(%Saledetaill{}, @invalid_attrs)
    refute changeset.valid?
  end
end
