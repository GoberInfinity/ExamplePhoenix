defmodule Otherpool.Sale_TypeControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Sale_Type
  @valid_attrs %{name_sale: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sale__type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    sale__type = Repo.insert! %Sale_Type{}
    conn = get conn, sale__type_path(conn, :show, sale__type)
    assert json_response(conn, 200)["data"] == %{"id" => sale__type.id,
      "name_sale" => sale__type.name_sale}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sale__type_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, sale__type_path(conn, :create), sale__type: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Sale_Type, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sale__type_path(conn, :create), sale__type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sale__type = Repo.insert! %Sale_Type{}
    conn = put conn, sale__type_path(conn, :update, sale__type), sale__type: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Sale_Type, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sale__type = Repo.insert! %Sale_Type{}
    conn = put conn, sale__type_path(conn, :update, sale__type), sale__type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sale__type = Repo.insert! %Sale_Type{}
    conn = delete conn, sale__type_path(conn, :delete, sale__type)
    assert response(conn, 204)
    refute Repo.get(Sale_Type, sale__type.id)
  end
end
