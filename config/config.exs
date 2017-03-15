# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :otherpool,
  ecto_repos: [Otherpool.Repo]

# Configures the endpoint
config :otherpool, Otherpool.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IZftWfmdhQ8UkDZ2d80BSZ1usZecYgI0rwAUvefkwhekEvK+xngs8i6TChmEEI3b",
  render_errors: [view: Otherpool.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Otherpool.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures JaSerializer
config :phoenix, :format_encoders,
  "json-api": Poison

config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
