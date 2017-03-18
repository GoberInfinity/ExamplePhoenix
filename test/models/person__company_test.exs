defmodule Otherpool.Person_CompanyTest do
  use Otherpool.ModelCase

  alias Otherpool.Person_Company

  @valid_attrs %{name_company: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Person_Company.changeset(%Person_Company{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Person_Company.changeset(%Person_Company{}, @invalid_attrs)
    refute changeset.valid?
  end
end
