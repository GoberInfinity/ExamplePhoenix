defmodule Otherpool.Person_PhoneControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Person_Phone
  @valid_attrs %{phone_number: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, person__phone_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    person__phone = Repo.insert! %Person_Phone{}
    conn = get conn, person__phone_path(conn, :show, person__phone)
    assert json_response(conn, 200)["data"] == %{"id" => person__phone.id,
      "phone_number" => person__phone.phone_number,
      "person_id" => person__phone.person_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, person__phone_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, person__phone_path(conn, :create), person__phone: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Person_Phone, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, person__phone_path(conn, :create), person__phone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    person__phone = Repo.insert! %Person_Phone{}
    conn = put conn, person__phone_path(conn, :update, person__phone), person__phone: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Person_Phone, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    person__phone = Repo.insert! %Person_Phone{}
    conn = put conn, person__phone_path(conn, :update, person__phone), person__phone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    person__phone = Repo.insert! %Person_Phone{}
    conn = delete conn, person__phone_path(conn, :delete, person__phone)
    assert response(conn, 204)
    refute Repo.get(Person_Phone, person__phone.id)
  end
end
