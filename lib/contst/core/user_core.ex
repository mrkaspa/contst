defmodule Contst.Core.UserCore do
  alias Contst.Repo
  alias Contst.Models.User
  alias Ecto.Multi

  @spec get_by(Keyword.t(), %User{}) :: %User{}
  def get_by(params, default \\ %User{}) do
    case Repo.get_by(User, params) do
      nil ->
        default

      user ->
        user
    end
  end

  @spec store_user(%User{}, map) :: Contst.Types.transaction()
  def(store_user(user, params)) do
    Multi.new()
    |> Multi.insert_or_update(:user, User.register_changeset(user, params))
    |> Multi.run(:user_token, fn
      %{user: %User{api_token: nil} = user} ->
        store_token(user)

      %{user: user} ->
        {:ok, user}
    end)
    |> Repo.transaction()
  end

  defp store_token(%User{id: user_id} = user) do
    token = Phoenix.Token.sign(ContstWeb.Endpoint, get_seed(), user_id)

    user
    |> User.api_token_changeset(token)
    |> Repo.update()
  end

  defp get_seed() do
    Application.get_env(:contst, :seed, "")
  end
end
