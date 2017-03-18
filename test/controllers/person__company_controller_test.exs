defmodule Otherpool.Person_CompanyControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Person_Company
  @valid_attrs %{name_company: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, person__company_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    person__company = Repo.insert! %Person_Company{}
    conn = get conn, person__company_path(conn, :show, person__company)
    assert json_response(conn, 200)["data"] == %{"id" => person__company.id,
      "name_company" => person__company.name_company,
      "person_id" => person__company.person_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, person__company_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, person__company_path(conn, :create), person__company: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Person_Company, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, person__company_path(conn, :create), person__company: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    person__company = Repo.insert! %Person_Company{}
    conn = put conn, person__company_path(conn, :update, person__company), person__company: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Person_Company, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    person__company = Repo.insert! %Person_Company{}
    conn = put conn, person__company_path(conn, :update, person__company), person__company: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    person__company = Repo.insert! %Person_Company{}
    conn = delete conn, person__company_path(conn, :delete, person__company)
    assert response(conn, 204)
    refute Repo.get(Person_Company, person__company.id)
  end
end
