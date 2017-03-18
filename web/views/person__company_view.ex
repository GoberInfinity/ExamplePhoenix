defmodule Otherpool.Person_CompanyView do
  use Otherpool.Web, :view

  def render("index.json", %{person_companies: person_companies}) do
    %{data: render_many(person_companies, Otherpool.Person_CompanyView, "person__company.json")}
  end

  def render("show.json", %{person__company: person__company}) do
    %{data: render_one(person__company, Otherpool.Person_CompanyView, "person__company.json")}
  end

  def render("person__company.json", %{person__company: person__company}) do
    %{id: person__company.id,
      name_company: person__company.name_company,
      person_id: person__company.person_id}
  end
end
