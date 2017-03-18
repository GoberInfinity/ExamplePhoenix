defmodule Otherpool.PersonTest do
  use Otherpool.ModelCase

  alias Otherpool.Person

  @valid_attrs %{age: 42, birthday: %{day: 17, month: 4, year: 2010}, email: "some content", first_name: "some content", last_name: "some content", middle_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Person.changeset(%Person{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Person.changeset(%Person{}, @invalid_attrs)
    refute changeset.valid?
  end
end
