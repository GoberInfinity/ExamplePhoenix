defmodule Otherpool.SaledetaillView do
  use Otherpool.Web, :view

  def render("index.json", %{saledetaills: saledetaills}) do
    %{data: render_many(saledetaills, Otherpool.SaledetaillView, "saledetaill.json")}
  end

  def render("show.json", %{saledetaill: saledetaill}) do
    %{data: render_one(saledetaill, Otherpool.SaledetaillView, "saledetaill.json")}
  end

  def render("saledetaill.json", %{saledetaill: saledetaill}) do
    %{id: saledetaill.id,
      order_date: saledetaill.order_date,
      due_date: saledetaill.due_date,
      subtotal: saledetaill.subtotal,
      sale_type_id: saledetaill.sale_type_id,
      userp_id: saledetaill.userp_id}
  end
end
