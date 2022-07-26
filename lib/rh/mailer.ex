defmodule Rh.Mailer do
  @moduledoc """
  Send emails.
  """
  use Swoosh.Mailer, otp_app: :rh
end
