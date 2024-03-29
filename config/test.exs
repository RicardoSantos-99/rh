import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rh, Rh.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "rh_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :rh, Rh.Mailer, adapter: Bamboo.TestAdapter

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rh, RhWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "L7SsPiuqdxK+kT85Y+IcgxTxhk3d++xGjDg/KCKTwFLeiwPx1bfgrHwEJdIxaZK2",
  server: false

# In test we don't send emails.
config :rh, Rh.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :rh, env: "uCx4idbEyU4kgMypH0ezMpHefEZJBqpHd6/yBXQ3omS2P25s7pdR+Vqk+Y5UUJMr"
