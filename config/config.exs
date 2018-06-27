# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cowwboy,
  ecto_repos: [Cowwboy.Repo]

# Configures the endpoint
config :cowwboy, CowwboyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xIghvB7j15gnmPkxwp57YSrY3htBzpwEU5zZgyi4jUgewuLVm2XWVqHELrxoRjGf",
  render_errors: [view: CowwboyWeb.ErrorView, format: "json", accepts: ~w(json)],
  pubsub: [name: Cowwboy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
