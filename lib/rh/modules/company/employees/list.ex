defmodule Rh.Modules.Company.Employees.List do
  import Rh.Repositories.EmployeeRepository

  alias Rh.Schema.Employee
  alias Rh.Utils.Auth

  def call(%Employee{company_id: company_id} = current_user) do
    case Auth.check_access(company_id, current_user, :ADMIN) do
      {:ok, _id} ->
        company_id
        |> find_employee_by_company_id
        |> handle_response

      {:error, message} ->
        {:error, message}
    end
  end

  defp handle_response(employees), do: {:ok, employees}
end
