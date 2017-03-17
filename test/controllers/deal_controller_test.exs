defmodule Otherpool.DealControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Deal
  @valid_attrs %{stock: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, deal_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    deal = Repo.insert! %Deal{}
    conn = get conn, deal_path(conn, :show, deal)
    assert json_response(conn, 200)["data"] == %{"id" => deal.id,
      "stock" => deal.stock,
      "user_id" => deal.user_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, deal_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, deal_path(conn, :create), deal: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Deal, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, deal_path(conn, :create), deal: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    deal = Repo.insert! %Deal{}
    conn = put conn, deal_path(conn, :update, deal), deal: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Deal, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    deal = Repo.insert! %Deal{}
    conn = put conn, deal_path(conn, :update, deal), deal: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    deal = Repo.insert! %Deal{}
    conn = delete conn, deal_path(conn, :delete, deal)
    assert response(conn, 204)
    refute Repo.get(Deal, deal.id)
  end
end
