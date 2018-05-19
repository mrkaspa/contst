defmodule Contst.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema("users") do
    field(:username, :string)
    field(:token, :string)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :token])
    |> validate_required([:username, :token])
  end
end
