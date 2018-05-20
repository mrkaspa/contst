defmodule Contst.Core.CampaignCore do
  alias Contst.Repo
  alias Contst.Models.Campaign
  import Ecto.Query

  def get_my_campaign(user_id, campaign_id) do
    user_id
    |> get_my_campaigns_query()
    |> (fn query -> from(c in query, where: c.id == ^campaign_id) end).()
    |> Repo.one()
  end

  def get_campaign(user_id, campaign_id) do
    user_id
    |> get_contest_campaigns_query()
    |> (fn query -> from([c, _] in query, where: c.id == ^campaign_id) end).()
    |> Repo.one()
  end

  def get_my_campaigns(user_id) do
    user_id
    |> get_my_campaigns_query()
    |> Repo.all()
  end

  def get_contest_campaigns(user_id) do
    user_id
    |> get_contest_campaigns_query()
    |> Repo.all()
  end

  def get_my_campaigns_query(user_id) do
    from(
      c in Campaign,
      where: c.user_id == ^user_id,
      preload: [posts: [:user]]
    )
  end

  def get_contest_campaigns_query(user_id) do
    from(
      c in Campaign,
      join: p in assoc(c, :posts),
      where: p.user_id == ^user_id,
      preload: [posts: [:user]]
    )
  end

  def store_campaign(params) do
    %Campaign{}
    |> Campaign.create_changeset(params)
    |> Repo.insert()
  end

  def update_campaign(campaign, params) do
    campaign
    |> Campaign.update_changeset(params)
    |> Repo.update()
  end

  def delete_campaign(campaign) do
    Repo.delete(campaign)
  end
end
