defmodule Otherpool.SaledetaillController do
  use Otherpool.Web, :controller

  alias Otherpool.Saledetaill

  def index(conn, _params) do
    saledetaills = Repo.all(Saledetaill)
    render(conn, "index.json", saledetaills: saledetaills)
  end

  def create(conn, %{"saledetaill" => saledetaill_params}) do
    changeset = Saledetaill.changeset(%Saledetaill{}, saledetaill_params)

    case Repo.insert(changeset) do
      {:ok, saledetaill} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", saledetaill_path(conn, :show, saledetaill))
        |> render("show.json", saledetaill: saledetaill)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    saledetaill = Repo.get!(Saledetaill, id)
    render(conn, "show.json", saledetaill: saledetaill)
  end

  def update(conn, %{"id" => id, "saledetaill" => saledetaill_params}) do
    saledetaill = Repo.get!(Saledetaill, id)
    changeset = Saledetaill.changeset(saledetaill, saledetaill_params)

    case Repo.update(changeset) do
      {:ok, saledetaill} ->
        render(conn, "show.json", saledetaill: saledetaill)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    saledetaill = Repo.get!(Saledetaill, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(saledetaill)

    send_resp(conn, :no_content, "")
  end
end
