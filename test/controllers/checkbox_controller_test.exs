defmodule Otherpool.CheckboxControllerTest do
  use Otherpool.ConnCase

  alias Otherpool.Checkbox
  alias Otherpool.Repo

  @valid_attrs %{checked: true, description: "some content"}
  @invalid_attrs %{}

  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do 
    list = Repo.insert!(%Otherpool.List{})

    %{
      "list" => %{
        "data" => %{
          "type" => "list",
          "id" => list.id
        }
      },
    }
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, checkbox_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    checkbox = Repo.insert! %Checkbox{}
    conn = get conn, checkbox_path(conn, :show, checkbox)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{checkbox.id}"
    assert data["type"] == "checkbox"
    assert data["attributes"]["description"] == checkbox.description
    assert data["attributes"]["checked"] == checkbox.checked
    assert data["attributes"]["list_id"] == checkbox.list_id
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, checkbox_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, checkbox_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "checkbox",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Checkbox, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, checkbox_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "checkbox",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    checkbox = Repo.insert! %Checkbox{}
    conn = put conn, checkbox_path(conn, :update, checkbox), %{
      "meta" => %{},
      "data" => %{
        "type" => "checkbox",
        "id" => checkbox.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Checkbox, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    checkbox = Repo.insert! %Checkbox{}
    conn = put conn, checkbox_path(conn, :update, checkbox), %{
      "meta" => %{},
      "data" => %{
        "type" => "checkbox",
        "id" => checkbox.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    checkbox = Repo.insert! %Checkbox{}
    conn = delete conn, checkbox_path(conn, :delete, checkbox)
    assert response(conn, 204)
    refute Repo.get(Checkbox, checkbox.id)
  end

end
