defmodule Otherpool.PageController do
  use Otherpool.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
