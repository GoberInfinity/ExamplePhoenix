defmodule Otherpool.PersonView do
  use Otherpool.Web, :view

  def render("index.json", %{persons: persons}) do
    %{data: render_many(persons, Otherpool.PersonView, "person.json")}
  end

  def render("show.json", %{person: person}) do
    %{data: render_one(person, Otherpool.PersonView, "person.json")}
  end

  def render("person.json", %{person: person}) do
    %{id: person.id,
      first_name: person.first_name,
      middle_name: person.middle_name,
      last_name: person.last_name,
      email: person.email,
      age: person.age,
      birthday: person.birthday}
  end
end
