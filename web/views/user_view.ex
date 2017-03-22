defmodule Otherpool.UserView do
  use Otherpool.Web, :view
  use JaSerializer.PhoenixView
  
  attributes [:fullname, :email, :id, :inserted_at, :updated_at]
#  def render("index.json", %{users: users}) do
#    %{data: render_many(users, Otherpool.UserView, "user.json")}
#  end#
#
#  def render("show.json", %{user: user}) do
#    %{data: render_one(user, Otherpool.UserView, "user.json")}
#  end
#
#  def render("user.json", %{user: user}) do
#    %{id: user.id,
#      fullname: user.fullname,
#      email: user.email}
#  end
#end

end    
