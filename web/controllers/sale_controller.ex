defmodule Otherpool.SaleController do
  use Otherpool.Web, :controller

  alias Otherpool.Sale

  def index(conn, _params) do
    sales = Repo.all(Sale)
    render(conn, "index.json", sales: sales)
  end

  def create(conn, %{"sale" => sale_params}) do
    changeset = Sale.changeset(%Sale{}, sale_params)

    case Repo.insert(changeset) do
      {:ok, sale} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", sale_path(conn, :show, sale))
        |> render("show.json", sale: sale)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sale = Repo.get!(Sale, id)
    render(conn, "show.json", sale: sale)
  end

  def update(conn, %{"id" => id, "sale" => sale_params}) do
    sale = Repo.get!(Sale, id)
    changeset = Sale.changeset(sale, sale_params)

    case Repo.update(changeset) do
      {:ok, sale} ->
        render(conn, "show.json", sale: sale)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sale = Repo.get!(Sale, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sale)

    send_resp(conn, :no_content, "")
  end
end
