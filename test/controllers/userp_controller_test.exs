defmodule Otherpool.UserpControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Userp
  @valid_attrs %{password_hash: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, userp_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    userp = Repo.insert! %Userp{}
    conn = get conn, userp_path(conn, :show, userp)
    assert json_response(conn, 200)["data"] == %{"id" => userp.id,
      "password_hash" => userp.password_hash,
      "person_id" => userp.person_id,
      "type_id" => userp.type_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, userp_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, userp_path(conn, :create), userp: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Userp, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, userp_path(conn, :create), userp: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    userp = Repo.insert! %Userp{}
    conn = put conn, userp_path(conn, :update, userp), userp: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Userp, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    userp = Repo.insert! %Userp{}
    conn = put conn, userp_path(conn, :update, userp), userp: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    userp = Repo.insert! %Userp{}
    conn = delete conn, userp_path(conn, :delete, userp)
    assert response(conn, 204)
    refute Repo.get(Userp, userp.id)
  end
end
