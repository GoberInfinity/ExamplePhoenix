defmodule Otherpool.Person_CompanyController do
  use Otherpool.Web, :controller

  alias Otherpool.Person_Company

  def index(conn, _params) do
    person_companies = Repo.all(Person_Company)
    render(conn, "index.json", person_companies: person_companies)
  end

  def create(conn, %{"person__company" => person__company_params}) do
    changeset = Person_Company.changeset(%Person_Company{}, person__company_params)

    case Repo.insert(changeset) do
      {:ok, person__company} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", person__company_path(conn, :show, person__company))
        |> render("show.json", person__company: person__company)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    person__company = Repo.get!(Person_Company, id)
    render(conn, "show.json", person__company: person__company)
  end

  def update(conn, %{"id" => id, "person__company" => person__company_params}) do
    person__company = Repo.get!(Person_Company, id)
    changeset = Person_Company.changeset(person__company, person__company_params)

    case Repo.update(changeset) do
      {:ok, person__company} ->
        render(conn, "show.json", person__company: person__company)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Otherpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    person__company = Repo.get!(Person_Company, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(person__company)

    send_resp(conn, :no_content, "")
  end
end
