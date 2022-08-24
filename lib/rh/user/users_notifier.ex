defmodule Rh.User.UsersNotifier do
  import Swoosh.Email
  alias Rh.Mailer

  def deliver_welcome(%{name: name, email: email}) do
    new()
    |> to({name, email})
    |> from({"Phoenix Team", "team@example.com"})
    |> subject("Welcome to Phoenix, #{name}!")
    |> html_body("<h1>Hello, #{name}</h1>")
    |> text_body("Hello, #{name}\n")
    |> Mailer.deliver()
  end

  def deliver_welcome_email(%{name: name, email: email}) do
    new()
    |> to({name, email})
    |> from({"Phoenix Team", "team@example.com"})
    |> subject("Welcome to Phoenix, #{name}!")
    |> html_body("<h1>Hello, #{name}</h1>")
    |> text_body("Hello, #{name}\n")
    |> Mailer.deliver()
  end
end
