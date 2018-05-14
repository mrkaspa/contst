defmodule ContstWeb.PageController do
  use ContstWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
