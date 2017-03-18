defmodule Otherpool.User_TypeControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.User_Type
  @valid_attrs %{name_type: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user__type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user__type = Repo.insert! %User_Type{}
    conn = get conn, user__type_path(conn, :show, user__type)
    assert json_response(conn, 200)["data"] == %{"id" => user__type.id,
      "name_type" => user__type.name_type}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user__type_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user__type_path(conn, :create), user__type: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User_Type, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user__type_path(conn, :create), user__type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user__type = Repo.insert! %User_Type{}
    conn = put conn, user__type_path(conn, :update, user__type), user__type: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User_Type, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user__type = Repo.insert! %User_Type{}
    conn = put conn, user__type_path(conn, :update, user__type), user__type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user__type = Repo.insert! %User_Type{}
    conn = delete conn, user__type_path(conn, :delete, user__type)
    assert response(conn, 204)
    refute Repo.get(User_Type, user__type.id)
  end
end
