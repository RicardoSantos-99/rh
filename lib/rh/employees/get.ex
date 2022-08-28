defmodule Rh.Employees.Get do
  import Rh.Repositories.EmployeeRepository

  alias Ecto.UUID
  alias Rh.Schema.Employee
  alias Rh.Utils.Auth

  def by_id(employee_id, current_user) do
    with %Employee{company_id: company_id} = employee <- find_employee_by_id(employee_id),
         {:ok, _id} <- Auth.check_access(company_id, current_user, :RECRUIT),
         {:ok, _uuid} <- UUID.cast(employee_id) do
      {:ok, employee}
    else
      nil -> {:error, "Affiliate not found"}
      {:error, message} -> {:error, message}
      :error -> {:error, "Invalid UUID"}
    end
  end

  def by_email(email, _current_user) do
    case find_employee_by_email(email) do
      nil -> {:error, "Employee not found"}
      employee -> {:ok, employee}
    end
  end
end
