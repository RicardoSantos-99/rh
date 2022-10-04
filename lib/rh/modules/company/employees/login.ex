defmodule Rh.Modules.Company.Employees.Login do
  alias Rh.Modules.Company.Employees.Update, as: UpdateEmployee
  alias Rh.Repositories.EmployeeRepository
  alias Rh.Schema.Employee
  alias RhWeb.Auth.Guardian

  def call(%{email: email, password: password}) do
    with {:ok, employee} <- login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(employee),
         {:ok, _} <- UpdateEmployee.store_token(employee, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def login_with_email_pass(email, password) do
    %Employee{password_hash: hash} = employee = EmployeeRepository.find_employee_by_email(email)

    case Pbkdf2.verify_pass(password, hash) do
      true -> {:ok, employee}
      false -> {:error, "Please verify your credentials"}
    end
  end
end
