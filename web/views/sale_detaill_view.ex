defmodule Otherpool.SaleDetaillView do
  use Otherpool.Web, :view

  def render("index.json", %{sale_detaills: sale_detaills}) do
    %{data: render_many(sale_detaills, Otherpool.SaleDetaillView, "sale_detaill.json")}
  end

  def render("show.json", %{sale_detaill: sale_detaill}) do
    %{data: render_one(sale_detaill, Otherpool.SaleDetaillView, "sale_detaill.json")}
  end

  def render("sale_detaill.json", %{sale_detaill: sale_detaill}) do
    %{id: sale_detaill.id,
      order_date: sale_detaill.order_date,
      due_date: sale_detaill.due_date,
      subtotal: sale_detaill.subtotal,
      sale_type_id: sale_detaill.sale_type_id,
      userp_id: sale_detaill.userp_id}
  end
end
