defmodule Otherpool.SaleDetaillController do
  use Otherpool.Web, :controller

  alias Otherpool.SaleDetaill

  def index(conn, _params) do
    sale_detaills = Repo.all(SaleDetaill)
    render(conn, "index.json", sale_detaills: sale_detaills)
  end

  def create(conn, %{"sale_detaill" => sale_detaill_params}) do
    changeset = SaleDetaill.changeset(%SaleDetaill{}, sale_detaill_params)

    case Repo.insert(changeset) do
      {:ok, sale_detaill} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", sale_detaill_path(conn, :show, sale_detaill))
        |> render("show.json", sale_detaill: sale_detaill)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sale_detaill = Repo.get!(SaleDetaill, id)
    render(conn, "show.json", sale_detaill: sale_detaill)
  end

  def update(conn, %{"id" => id, "sale_detaill" => sale_detaill_params}) do
    sale_detaill = Repo.get!(SaleDetaill, id)
    changeset = SaleDetaill.changeset(sale_detaill, sale_detaill_params)

    case Repo.update(changeset) do
      {:ok, sale_detaill} ->
        render(conn, "show.json", sale_detaill: sale_detaill)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sale_detaill = Repo.get!(SaleDetaill, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sale_detaill)

    send_resp(conn, :no_content, "")
  end
end
