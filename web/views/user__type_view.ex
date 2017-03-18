defmodule Otherpool.User_TypeView do
  use Otherpool.Web, :view

  def render("index.json", %{user_types: user_types}) do
    %{data: render_many(user_types, Otherpool.User_TypeView, "user__type.json")}
  end

  def render("show.json", %{user__type: user__type}) do
    %{data: render_one(user__type, Otherpool.User_TypeView, "user__type.json")}
  end

  def render("user__type.json", %{user__type: user__type}) do
    %{id: user__type.id,
      name_type: user__type.name_type}
  end
end
