defmodule Otherpool.CheckboxController do
  use Otherpool.Web, :controller

  alias Otherpool.Checkbox
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    checkboxes = Repo.all(Checkbox)
    render(conn, "index.json-api", data: checkboxes)
  end

  def create(conn, %{"data" => data = %{"type" => "checkbox", "attributes" => _checkbox_params}}) do
    changeset = Checkbox.changeset(%Checkbox{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, checkbox} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", checkbox_path(conn, :show, checkbox))
        |> render("show.json-api", data: checkbox)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    checkbox = Repo.get!(Checkbox, id)
    render(conn, "show.json-api", data: checkbox)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "checkbox", "attributes" => _checkbox_params}}) do
    checkbox = Repo.get!(Checkbox, id)
    changeset = Checkbox.changeset(checkbox, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, checkbox} ->
        render(conn, "show.json-api", data: checkbox)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    checkbox = Repo.get!(Checkbox, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(checkbox)

    send_resp(conn, :no_content, "")
  end

end
