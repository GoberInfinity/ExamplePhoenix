defmodule Otherpool.DummyController do
  use Otherpool.Web, :controller

  alias Otherpool.Dummy
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    dummies = Repo.all(Dummy)
    render(conn, "index.json-api", data: dummies)
  end

  def create(conn, dummy_params) do
      changeset = Dummy.changeset(%Dummy{}, dummy_params)

    case Repo.insert(changeset) do
      {:ok, dummy} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", dummy_path(conn, :show, dummy))
        |> render("show.json-api", data: dummy)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dummy = Repo.get!(Dummy, id)
    render(conn, "show.json-api", data: dummy)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "dummy", "attributes" => _dummy_params}}) do
    dummy = Repo.get!(Dummy, id)
    changeset = Dummy.changeset(dummy, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, dummy} ->
        render(conn, "show.json-api", data: dummy)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dummy = Repo.get!(Dummy, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(dummy)

    send_resp(conn, :no_content, "")
  end

end
