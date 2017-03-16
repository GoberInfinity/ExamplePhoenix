defmodule Otherpool.DummyControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Dummy
  alias Otherpool.Repo

  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do
    %{}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, dummy_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    dummy = Repo.insert! %Dummy{}
    conn = get conn, dummy_path(conn, :show, dummy)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{dummy.id}"
    assert data["type"] == "dummy"
    assert data["attributes"]["name"] == dummy.name
    assert data["attributes"]["age"] == dummy.age
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, dummy_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, dummy_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "dummy",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Dummy, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, dummy_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "dummy",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    dummy = Repo.insert! %Dummy{}
    conn = put conn, dummy_path(conn, :update, dummy), %{
      "meta" => %{},
      "data" => %{
        "type" => "dummy",
        "id" => dummy.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Dummy, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    dummy = Repo.insert! %Dummy{}
    conn = put conn, dummy_path(conn, :update, dummy), %{
      "meta" => %{},
      "data" => %{
        "type" => "dummy",
        "id" => dummy.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    dummy = Repo.insert! %Dummy{}
    conn = delete conn, dummy_path(conn, :delete, dummy)
    assert response(conn, 204)
    refute Repo.get(Dummy, dummy.id)
  end

end
