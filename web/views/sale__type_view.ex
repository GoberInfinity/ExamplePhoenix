defmodule Otherpool.Sale_TypeView do
  use Otherpool.Web, :view

  def render("index.json", %{sale_types: sale_types}) do
    %{data: render_many(sale_types, Otherpool.Sale_TypeView, "sale__type.json")}
  end

  def render("show.json", %{sale__type: sale__type}) do
    %{data: render_one(sale__type, Otherpool.Sale_TypeView, "sale__type.json")}
  end

  def render("sale__type.json", %{sale__type: sale__type}) do
    %{id: sale__type.id,
      name_sale: sale__type.name_sale}
  end
end
