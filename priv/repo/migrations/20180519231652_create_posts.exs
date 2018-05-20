defmodule Contst.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:user_id, references(:users, on_delete: :nothing))
      add(:campaign_id, references(:campaigns, on_delete: :nothing))
      add(:pic_url, :string, null: false)
      add(:likes, :integer, null: false)
      add(:comments, :integer, null: false)
      add(:valid, :boolean, null: false, default: true)

      timestamps(type: :utc_datetime)
    end
  end
end
