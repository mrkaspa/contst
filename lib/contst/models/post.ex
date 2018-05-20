defmodule Contst.Models.Post do
  use Ecto.Schema

  schema("posts") do
    field(:pic_url, :string)
    field(:likes, :integer)
    field(:comments, :integer)
    field(:valid, :boolean)
    field(:winner, :boolean)

    belongs_to(:user, Contst.Models.User)
    belongs_to(:campaign, Contst.Models.Campaign)

    timestamps()
  end
end
