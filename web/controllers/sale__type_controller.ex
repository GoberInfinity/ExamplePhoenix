defmodule Otherpool.Sale_TypeController do
  use Otherpool.Web, :controller

  alias Otherpool.Sale_Type

  def index(conn, _params) do
    sale_types = Repo.all(Sale_Type)
    render(conn, "index.json", sale_types: sale_types)
  end

  def create(conn, %{"sale__type" => sale__type_params}) do
    changeset = Sale_Type.changeset(%Sale_Type{}, sale__type_params)

    case Repo.insert(changeset) do
      {:ok, sale__type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", sale__type_path(conn, :show, sale__type))
        |> render("show.json", sale__type: sale__type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sale__type = Repo.get!(Sale_Type, id)
    render(conn, "show.json", sale__type: sale__type)
  end

  def update(conn, %{"id" => id, "sale__type" => sale__type_params}) do
    sale__type = Repo.get!(Sale_Type, id)
    changeset = Sale_Type.changeset(sale__type, sale__type_params)

    case Repo.update(changeset) do
      {:ok, sale__type} ->
        render(conn, "show.json", sale__type: sale__type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sale__type = Repo.get!(Sale_Type, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sale__type)

    send_resp(conn, :no_content, "")
  end
end
