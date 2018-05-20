defmodule Contst.Models.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  schema("campaigns") do
    field(:name, :string)
    field(:description, :string)
    field(:tag, :string)
    field(:start_date, :utc_datetime)
    field(:finish_date, :utc_datetime)
    field(:winners, :integer)

    belongs_to(:user, Contst.Models.User)
    has_many(:posts, Contst.Models.Post)

    timestamps()
  end

  @create_attrs [
    :name,
    :description,
    :tag,
    :start_date,
    :finish_date,
    :winners
  ]

  @update_attrs [
    :name,
    :description,
    :start_date,
    :finish_date,
    :winners
  ]

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @create_attrs)
    |> validate_required(@create_attrs)
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @update_attrs)
    |> validate_required(@update_attrs)
  end
end
