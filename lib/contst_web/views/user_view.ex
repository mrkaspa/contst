defmodule ContstWeb.UserView do
  use ContstWeb, :view

  def render("create.json", %{user: user}) do
    user
  end

  def render("create.json", %{changeset: changeset}) do
    errors = errors_to_json(changeset)
    %{errors: errors}
  end
end
