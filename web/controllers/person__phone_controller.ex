defmodule Otherpool.Person_PhoneController do
  use Otherpool.Web, :controller

  alias Otherpool.Person_Phone

  def index(conn, _params) do
    person_phones = Repo.all(Person_Phone)
    render(conn, "index.json", person_phones: person_phones)
  end

  def create(conn, %{"person__phone" => person__phone_params}) do
    changeset = Person_Phone.changeset(%Person_Phone{}, person__phone_params)

    case Repo.insert(changeset) do
      {:ok, person__phone} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", person__phone_path(conn, :show, person__phone))
        |> render("show.json", person__phone: person__phone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    person__phone = Repo.get!(Person_Phone, id)
    render(conn, "show.json", person__phone: person__phone)
  end

  def update(conn, %{"id" => id, "person__phone" => person__phone_params}) do
    person__phone = Repo.get!(Person_Phone, id)
    changeset = Person_Phone.changeset(person__phone, person__phone_params)

    case Repo.update(changeset) do
      {:ok, person__phone} ->
        render(conn, "show.json", person__phone: person__phone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    person__phone = Repo.get!(Person_Phone, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(person__phone)

    send_resp(conn, :no_content, "")
  end
end
