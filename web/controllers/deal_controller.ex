defmodule Otherpool.DealController do
    require Logger
  use Otherpool.Web, :controller

  alias Otherpool.Deal

  def index(conn, _params) do
    dealers = Repo.all(Deal)
    render(conn, "index.json", dealers: dealers)
  end

  def create(conn, %{"deal" => deal_params}) do
    changeset = Deal.changeset(%Deal{}, deal_params)

    case Repo.insert(changeset) do
      {:ok, deal} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", deal_path(conn, :show, deal))
        |> render("show.json", deal: deal)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end
    
    def add_dealer(conn, %{"deal" => deal_params, "user_id" => user_id}) do
        changeset = Deal.changeset(%Deal{}, Map.put(deal_params, "user_id", user_id))
        Logger.info "ESTO ES PORQUE PASO A ADD_DEALER"

  case Repo.insert(changeset) do
      {:ok, deal} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", deal_path(conn, :show, deal))
        |> render("show.json", deal: deal)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end
    

  def show(conn, %{"id" => id}) do
    deal = Repo.get!(Deal, id)
    render(conn, "show.json", deal: deal)
  end

  def update(conn, %{"id" => id, "deal" => deal_params}) do
    deal = Repo.get!(Deal, id)
    changeset = Deal.changeset(deal, deal_params)

    case Repo.update(changeset) do
      {:ok, deal} ->
        render(conn, "show.json", deal: deal)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deal = Repo.get!(Deal, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(deal)

    send_resp(conn, :no_content, "")
  end
end
