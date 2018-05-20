defmodule ContstWeb.CampaignController do
  use ContstWeb, :controller
  alias Contst.Core.CampaignCore

  def index(conn, %{user_id: user_id}) do
    campaigns = CampaignCore.get_my_campaigns(user_id)
    render(conn, "index.json", campaigns: campaigns)
  end

  def index_contest(conn, %{user_id: user_id}) do
    campaigns = CampaignCore.get_contest_campaigns(user_id)
    render(conn, "index.json", campaigns: campaigns)
  end

  def show(conn, %{id: id, user_id: user_id}) do
    campaign = CampaignCore.get_my_campaign(user_id, id)
    render(conn, "show.json", campaign: campaign)
  end

  def show_contest(conn, %{id: id, user_id: user_id}) do
    campaign = CampaignCore.get_campaign(user_id, id)
    render(conn, "show.json", campaign: campaign)
  end

  def create(conn, params) do
    CampaignCore.store_campaign(params)
    |> case do
      {:ok, campaign} ->
        render(conn, "show.json", campaign: campaign)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render("errors.json", changeset: changeset)
    end
  end

  def update(conn, %{id: id, user_id: user_id} = params) do
    user_id
    |> CampaignCore.get_my_campaign(id)
    |> CampaignCore.update_campaign(params)
    |> case do
      {:ok, campaign} ->
        render(conn, "show.json", campaign: campaign)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render("errors.json", changeset: changeset)
    end
  end

  def delete(conn, %{id: id, user_id: user_id}) do
    user_id
    |> CampaignCore.get_my_campaign(id)
    |> CampaignCore.delete_campaign()
    |> case do
      {:ok, _campaign} ->
        render(conn, "empty.json")

      {:error, _} ->
        conn
        |> put_status(:bad_request)
        |> render("empty.json")
    end
  end
end
