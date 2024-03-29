defmodule Rh.MixProject do
  use Mix.Project

  def project do
    [
      app: :rh,
      version: "0.1.1",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      # Test
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Rh.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.10"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:swoosh, "~> 1.3"},
      {:phoenix_swoosh, "~> 1.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:pbkdf2_elixir, "~> 2.0"},
      {:absinthe, "~> 1.5"},
      {:absinthe_plug, "~> 1.5"},
      {:crudry, "~> 2.4.0"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:ex_machina, "~> 2.7.0", only: :test},
      {:bamboo, "~> 1.1"},
      {:guardian, "~> 2.0"},
      {:ecto_psql_extras, "~> 0.6"},
      {:circular_buffer, "~> 0.4.0"},
      {:redix, "~> 1.1"},
      {:castore, ">= 0.0.0"},
      {:git_ops, "~> 2.4.5", only: [:dev]},
      {:todo, "~> 1.5"},
      {:enum_type, "~> 1.1.0"},
      {:passgen, "~> 0.1.1"},
      {:pre_commit, "~> 0.3.4", only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
