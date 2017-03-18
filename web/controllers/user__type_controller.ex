defmodule Otherpool.User_TypeController do
  use Otherpool.Web, :controller

  alias Otherpool.User_Type

  def index(conn, _params) do
    user_types = Repo.all(User_Type)
    render(conn, "index.json", user_types: user_types)
  end

  def create(conn, %{"user__type" => user__type_params}) do
    changeset = User_Type.changeset(%User_Type{}, user__type_params)

    case Repo.insert(changeset) do
      {:ok, user__type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user__type_path(conn, :show, user__type))
        |> render("show.json", user__type: user__type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user__type = Repo.get!(User_Type, id)
    render(conn, "show.json", user__type: user__type)
  end

  def update(conn, %{"id" => id, "user__type" => user__type_params}) do
    user__type = Repo.get!(User_Type, id)
    changeset = User_Type.changeset(user__type, user__type_params)

    case Repo.update(changeset) do
      {:ok, user__type} ->
        render(conn, "show.json", user__type: user__type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user__type = Repo.get!(User_Type, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user__type)

    send_resp(conn, :no_content, "")
  end
end
