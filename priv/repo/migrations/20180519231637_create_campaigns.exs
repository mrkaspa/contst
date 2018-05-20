defmodule Contst.Repo.Migrations.CreateCampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add(:user_id, references(:users, on_delete: :nothing))
      add(:name, :string, null: false)
      add(:description, :string, null: false)
      add(:tag, :string, null: false)
      add(:start_date, :utc_datetime, null: false)
      add(:finish_date, :utc_datetime, null: false)
      add(:winners, :integer, null: false)

      timestamps(type: :utc_datetime)
    end
  end
end
