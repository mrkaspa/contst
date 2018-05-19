defmodule ContstWeb.UserView do
  use ContstWeb, :view

  def render("create.json", %{user: user}) do
    IO.inspect(user)
    user
  end

  def render("create.json", %{changeset: changeset}) do
    errors = errors_to_json(changeset)
    %{errors: errors}
  end
end
