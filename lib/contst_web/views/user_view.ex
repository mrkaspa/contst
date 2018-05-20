defmodule ContstWeb.UserView do
  use ContstWeb, :view

  def render("create.json", %{user: user}) do
    user
  end
end
