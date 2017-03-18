defmodule Otherpool.Person_PhoneView do
  use Otherpool.Web, :view

  def render("index.json", %{person_phones: person_phones}) do
    %{data: render_many(person_phones, Otherpool.Person_PhoneView, "person__phone.json")}
  end

  def render("show.json", %{person__phone: person__phone}) do
    %{data: render_one(person__phone, Otherpool.Person_PhoneView, "person__phone.json")}
  end

  def render("person__phone.json", %{person__phone: person__phone}) do
    %{id: person__phone.id,
      phone_number: person__phone.phone_number,
      person_id: person__phone.person_id}
  end
end
