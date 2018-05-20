defmodule Contst.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:instagram_id, :string, null: false)
      add(:username, :string, null: false)
      add(:name, :string, null: false)
      add(:token, :string)
      add(:api_token, :text)
      add(:profile_picture, :string)
      add(:bio, :text)
      add(:website, :string)
      add(:is_business, :boolean)

      timestamps(type: :utc_datetime)
    end
  end
end
