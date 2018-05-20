defmodule ContstWeb.CampaignView do
  use ContstWeb, :view

  def render("index.json", %{campaigns: campaigns}) do
    Enum.map(campaigns, &render("show.json", %{campaign: &1}))
  end

  def render("show.json", %{campaign: campaign}) do
    campaign
  end
end
