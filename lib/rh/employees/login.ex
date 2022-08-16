defmodule Rh.Employees.Login do
  alias Rh.Employees
  alias Rh.Repo
  alias Rh.Schema.Employee
  alias RhWeb.Auth.Guardian

  def call(%{email: email, password: password}) do
    with {:ok, employee} <- login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(employee),
         {:ok, _} <- Employees.Update.store_token(employee, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def login_with_email_pass(email, password) do
    %Employee{password_hash: hash} =
      employee = Repo.get_by(Employee, email: String.downcase(email))

    case Pbkdf2.verify_pass(password, hash) do
      true -> {:ok, employee}
      false -> {:error, "Please verify your credentials"}
    end
  end
end
