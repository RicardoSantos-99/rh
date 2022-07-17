defmodule Rh.Repo do
  use Ecto.Repo,
    otp_app: :rh,
    adapter: Ecto.Adapters.Postgres
end
