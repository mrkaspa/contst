defmodule ContstWeb.UserController do
  use ContstWeb, :controller
  alias Contst.Repo
  alias Contst.Models.User

  def create(conn, %{"username" => username, "token" => _token} = params) do
    case Repo.get_by(User, username: username) do
      nil ->
        %User{}

      user ->
        user
    end
    |> User.changeset(params)
    |> Repo.insert_or_update()
    |> case do
      {:ok, user} ->
        conn
        |> render("create.json", user: user)

      {:error, %Ecto.Changeset{errors: errors}} ->
        conn
        |> put_status(:forbidden)
        |> render("create.json", errors: errors)
    end
  end
end
