defmodule Otherpool.SaleControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Sale
  @valid_attrs %{due_date: %{day: 17, month: 4, year: 2010}, order_date: %{day: 17, month: 4, year: 2010}, subtotal: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sale_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    sale = Repo.insert! %Sale{}
    conn = get conn, sale_path(conn, :show, sale)
    assert json_response(conn, 200)["data"] == %{"id" => sale.id,
      "order_date" => sale.order_date,
      "due_date" => sale.due_date,
      "subtotal" => sale.subtotal,
      "sale_type_id" => sale.sale_type_id,
      "userp_id" => sale.userp_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sale_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, sale_path(conn, :create), sale: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Sale, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sale_path(conn, :create), sale: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sale = Repo.insert! %Sale{}
    conn = put conn, sale_path(conn, :update, sale), sale: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Sale, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sale = Repo.insert! %Sale{}
    conn = put conn, sale_path(conn, :update, sale), sale: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sale = Repo.insert! %Sale{}
    conn = delete conn, sale_path(conn, :delete, sale)
    assert response(conn, 204)
    refute Repo.get(Sale, sale.id)
  end
end
