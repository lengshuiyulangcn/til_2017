# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :til,
  ecto_repos: [Til.Repo]

# Configures the endpoint
config :til, Til.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LS+5/LIm/UTQjlLuUpozTcGuYkeNF8+I+rpnGLrbdYcc2kU6qknGk4PeK7i0tlUN",
  render_errors: [view: Til.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Til.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Til",
  ttl: { 30, :days },
  secret_key: "8luO5+TyuPXOSyOa0oduBuAXB3pXm0Yrpy5qQICF8qm70HO5aH1nBAAN/3a9JE3Y",
  serializer: Til.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
