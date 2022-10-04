defmodule Rh.Modules.Company.Employees.Delete do
  @moduledoc """
    Delete an Employees.
  """

  import Rh.Repositories.EmployeeRepository

  alias Ecto.UUID
  alias Rh.Repo
  alias Rh.Schema.Employee
  alias Rh.Utils.Auth

  def call(employee_id, current_user) do
    with %Employee{company_id: company_id} = employee <- find_employee_by_id(employee_id),
         {:ok, _id} <- Auth.check_access(company_id, current_user, :ADMIN),
         {:ok, _uuid} <- UUID.cast(employee_id) do
      Repo.delete(employee)
    else
      nil -> {:error, "Employee not found"}
      {:error, message} -> {:error, message}
      :error -> {:error, "Invalid UUID"}
    end
  end
end
