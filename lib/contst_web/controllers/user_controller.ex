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
    |> User.register_changeset(params)
    |> Repo.insert_or_update()
    |> case do
      {:ok, user} ->
        render(conn, "create.json", user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render("create.json", changeset: changeset)
    end
  end

  def create(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> render("empty.json")
  end
end
