defmodule Rh.UserEmail do
  @moduledoc """
  This module is used to manage user emails.
  """
  import Swoosh.Email

  def send_email(%{name: name, email: email}) do
    new()
    |> from("rh@gmail.com")
    |> to(email)
    |> subject("Hello, good morning!")
    |> html_body("<h1>Hello #{name}</h1>")
    |> text_body("Hello #{name}\n")
  end
end