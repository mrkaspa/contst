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

  @register_attrs [
    :instagram_id,
    :username,
    :name,
    :token,
    :profile_picture,
    :bio,
    :website,
    :is_business
  ]

  @register_required_attrs [
    :instagram_id,
    :username,
    :name,
    :token
  ]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @register_attrs)
    |> validate_required(@register_required_attrs)
  end
end
