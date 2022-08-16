defmodule Rh.Utils.AuthHelper do
  @moduledoc false

  alias Rh.Employees
  alias Rh.Repo

  def login_with_email_pass(email, given_pass) do
    user = Repo.get_by(Employees, email: String.downcase(email))

    case Pbkdf2.verify_pass(given_pass, user.hash) do
      true -> {:ok, true}
      false -> {:error, "Please verify your credentials"}
    end
  end
end
