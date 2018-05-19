defmodule Contst.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:instagram_id, :string, null: false)
      add(:username, :string, null: false)
      add(:name, :string, null: false)
      add(:token, :text)
      add(:profile_picture, :string)
      add(:bio, :string)
      add(:website, :string)
      add(:is_business, :boolean)

      timestamps()
    end
  end
end
