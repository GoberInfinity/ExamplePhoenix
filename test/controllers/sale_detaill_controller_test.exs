defmodule Otherpool.SaleDetaillControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.SaleDetaill
  @valid_attrs %{due_date: %{day: 17, month: 4, year: 2010}, order_date: %{day: 17, month: 4, year: 2010}, subtotal: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sale_detaill_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    sale_detaill = Repo.insert! %SaleDetaill{}
    conn = get conn, sale_detaill_path(conn, :show, sale_detaill)
    assert json_response(conn, 200)["data"] == %{"id" => sale_detaill.id,
      "order_date" => sale_detaill.order_date,
      "due_date" => sale_detaill.due_date,
      "subtotal" => sale_detaill.subtotal,
      "sale_type_id" => sale_detaill.sale_type_id,
      "userp_id" => sale_detaill.userp_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sale_detaill_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, sale_detaill_path(conn, :create), sale_detaill: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(SaleDetaill, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sale_detaill_path(conn, :create), sale_detaill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sale_detaill = Repo.insert! %SaleDetaill{}
    conn = put conn, sale_detaill_path(conn, :update, sale_detaill), sale_detaill: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(SaleDetaill, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sale_detaill = Repo.insert! %SaleDetaill{}
    conn = put conn, sale_detaill_path(conn, :update, sale_detaill), sale_detaill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sale_detaill = Repo.insert! %SaleDetaill{}
    conn = delete conn, sale_detaill_path(conn, :delete, sale_detaill)
    assert response(conn, 204)
    refute Repo.get(SaleDetaill, sale_detaill.id)
  end
end
