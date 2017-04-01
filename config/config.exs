# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cci_demo_phoenix,
  ecto_repos: [CciDemoPhoenix.Repo]

# Configures the endpoint
config :cci_demo_phoenix, CciDemoPhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Am1md5HoDIu3wmydpII4ByULLc0LCMb/u6ZWVxvl+WfeNAkLFPuU9o5ezRdgXqLl",
  render_errors: [view: CciDemoPhoenix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CciDemoPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
