defmodule Otherpool.SaleView do
  use Otherpool.Web, :view

  def render("index.json", %{sales: sales}) do
    %{data: render_many(sales, Otherpool.SaleView, "sale.json")}
  end

  def render("show.json", %{sale: sale}) do
    %{data: render_one(sale, Otherpool.SaleView, "sale.json")}
  end

  def render("sale.json", %{sale: sale}) do
    %{id: sale.id,
      order_date: sale.order_date,
      due_date: sale.due_date,
      subtotal: sale.subtotal,
      sale_type_id: sale.sale_type_id,
      userp_id: sale.userp_id}
  end
end
