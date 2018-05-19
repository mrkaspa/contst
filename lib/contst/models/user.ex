defmodule Contst.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema("users") do
    field(:instagram_id, :string)
    field(:username, :string)
    field(:token, :string)
    field(:name, :string)
    field(:profile_picture, :string)
    field(:bio, :string)
    field(:website, :string)
    field(:is_business, :boolean)

    timestamps()
  end

  @attrs [
    :instagram_id,
    :username,
    :token,
    :name,
    :profile_picture,
    :bio,
    :website,
    :is_business
  ]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @attrs)
    |> validate_required(@attrs)
  end
end
