# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :contst,
  ecto_repos: [Contst.Repo]

# Configures the endpoint
config :contst, ContstWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HH7JZCTtBzIVpou367PW87Y8S+C0gt7WfPieFMMjcvG2tSMu8dYJaymy9nx5JM1l",
  render_errors: [view: ContstWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Contst.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
