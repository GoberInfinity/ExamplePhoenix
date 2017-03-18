defmodule Otherpool.SaledetaillControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Saledetaill
  @valid_attrs %{due_date: %{day: 17, month: 4, year: 2010}, order_date: %{day: 17, month: 4, year: 2010}, subtotal: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, saledetaill_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    saledetaill = Repo.insert! %Saledetaill{}
    conn = get conn, saledetaill_path(conn, :show, saledetaill)
    assert json_response(conn, 200)["data"] == %{"id" => saledetaill.id,
      "order_date" => saledetaill.order_date,
      "due_date" => saledetaill.due_date,
      "subtotal" => saledetaill.subtotal,
      "sale_type_id" => saledetaill.sale_type_id,
      "userp_id" => saledetaill.userp_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, saledetaill_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, saledetaill_path(conn, :create), saledetaill: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Saledetaill, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, saledetaill_path(conn, :create), saledetaill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    saledetaill = Repo.insert! %Saledetaill{}
    conn = put conn, saledetaill_path(conn, :update, saledetaill), saledetaill: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Saledetaill, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    saledetaill = Repo.insert! %Saledetaill{}
    conn = put conn, saledetaill_path(conn, :update, saledetaill), saledetaill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    saledetaill = Repo.insert! %Saledetaill{}
    conn = delete conn, saledetaill_path(conn, :delete, saledetaill)
    assert response(conn, 204)
    refute Repo.get(Saledetaill, saledetaill.id)
  end
end
