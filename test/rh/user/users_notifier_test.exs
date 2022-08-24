defmodule Rh.User.UsersNotifierTest do
  use ExUnit.Case, async: true
  import Swoosh.TestAssertions

  alias Rh.User.UsersNotifier

  test "deliver_welcome/1" do
    user = %{name: "Alice", email: "alice@example.com"}

    UsersNotifier.deliver_welcome(user)

    assert_email_sent(
      subject: "Welcome to Phoenix, Alice!",
      to: {"Alice", "alice@example.com"},
      text_body: ~r/Hello, Alice/
    )
  end

  test "deliver_welcome_email/1" do
    user = %{name: "Alice", email: "alice@example.com"}

    UsersNotifier.deliver_welcome_email(user)

    assert_email_sent(
      subject: "Welcome to Phoenix, Alice!",
      to: {"Alice", "alice@example.com"},
      text_body: ~r/Hello, Alice/
    )
  end
end
