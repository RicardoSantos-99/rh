defmodule Rh.UserEmail do
  @moduledoc """
  This module is used to manage user emails.
  """
  import Swoosh.Email

  def send_email(%{name: name, email: email, password: password}) do
    new()
    |> to({name, email})
    |> from({"rh", "rh@gmail.com"})
    |> subject("Hello, good morning!")
    |> html_body("<h1>Hello #{name}</h1>")
    |> text_body("Your credentials email: #{email} - password: #{password}\n")
  end
end
