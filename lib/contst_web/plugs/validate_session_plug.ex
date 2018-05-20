defmodule ContstWeb.ValidateSessionPlug do
  require Logger
  import Phoenix.Controller, only: [render: 3]
  import Plug.Conn
  alias Contst.Core.UserCore

  def init(_opts), do: nil

  def call(conn, _opts) do
    params = conn.params

    with [token] <- get_req_header(conn, "authorization"),
         {:ok, user_id} <- UserCore.decode_token(token) do
      %{conn | params: Map.put(params, :user_id, user_id)}
    else
      {:error, _error} ->
        forbid(conn)

      [] ->
        forbid(conn)
    end
  end

  defp forbid(conn) do
    conn
    |> put_status(:forbidden)
    |> halt()
    |> render(ContstWeb.ErrorView, "empty.json")
  end
end
