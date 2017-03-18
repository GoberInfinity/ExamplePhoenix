defmodule Otherpool.UserpController do
  use Otherpool.Web, :controller

  alias Otherpool.Userp

  def index(conn, _params) do
    userps = Repo.all(Userp)
    render(conn, "index.json", userps: userps)
  end

  def create(conn, %{"userp" => userp_params}) do
    changeset = Userp.changeset(%Userp{}, userp_params)

    case Repo.insert(changeset) do
      {:ok, userp} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", userp_path(conn, :show, userp))
        |> render("show.json", userp: userp)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    userp = Repo.get!(Userp, id)
    render(conn, "show.json", userp: userp)
  end

  def update(conn, %{"id" => id, "userp" => userp_params}) do
    userp = Repo.get!(Userp, id)
    changeset = Userp.changeset(userp, userp_params)

    case Repo.update(changeset) do
      {:ok, userp} ->
        render(conn, "show.json", userp: userp)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    userp = Repo.get!(Userp, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(userp)

    send_resp(conn, :no_content, "")
  end
end
