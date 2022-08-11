defmodule RhWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :rh

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
