defmodule Contst.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:instagram_id, :string, null: false)
      add(:username, :string, null: false)
      add(:token, :text, null: false)
      add(:name, :string, null: false)
      add(:profile_picture, :string, null: false)
      add(:bio, :string, null: false)
      add(:website, :string, null: false)
      add(:is_business, :boolean, null: false)

      timestamps()
    end
  end
end
