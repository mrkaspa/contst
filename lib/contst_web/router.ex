defmodule ContstWeb.Router do
  use ContstWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ContstWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  scope "/api", ContstWeb do
    pipe_through(:api)

    resources("/users", UserController, only: [:create])
  end

  scope "/api", ContstWeb do
    pipe_through([:api, ContstWeb.ValidateSessionPlug])

    resources("/campaigns", CampaignController, only: [:index, :show, :create, :update, :delete])
  end
end
