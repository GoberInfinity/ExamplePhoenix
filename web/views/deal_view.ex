defmodule Otherpool.DealView do
  use Otherpool.Web, :view

  def render("index.json", %{dealers: dealers}) do
    %{data: render_many(dealers, Otherpool.DealView, "deal.json")}
  end

  def render("show.json", %{deal: deal}) do
    %{data: render_one(deal, Otherpool.DealView, "deal.json")}
  end

  def render("deal.json", %{deal: deal}) do
    %{id: deal.id,
      stock: deal.stock,
      user_id: deal.user_id}
  end
end
