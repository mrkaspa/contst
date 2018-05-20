defmodule ContstWeb.UserController do
  use ContstWeb, :controller
  alias Contst.Core.UserCore

  def create(conn, %{"username" => username, "token" => _token} = params) do
    UserCore.get_by(username: username)
    |> UserCore.store_user(params)
    |> case do
      {:ok, %{user_token: user}} ->
        render(conn, "create.json", user: user)

      {:error, _, %Ecto.Changeset{} = changeset, _} ->
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
