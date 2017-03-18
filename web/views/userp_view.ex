defmodule Otherpool.UserpView do
  use Otherpool.Web, :view

  def render("index.json", %{userps: userps}) do
    %{data: render_many(userps, Otherpool.UserpView, "userp.json")}
  end

  def render("show.json", %{userp: userp}) do
    %{data: render_one(userp, Otherpool.UserpView, "userp.json")}
  end

  def render("userp.json", %{userp: userp}) do
    %{id: userp.id,
      password_hash: userp.password_hash,
      person_id: userp.person_id,
      type_id: userp.type_id}
  end
end
