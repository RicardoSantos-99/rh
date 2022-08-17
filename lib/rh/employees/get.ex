defmodule Rh.Employees.Get do
  alias Rh.Repositories.EmployeeRepository

  alias Ecto.UUID

  def by_id(id, _current_user) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  def by_email(email, _current_user) do
    case EmployeeRepository.find_employee_by_email(email) do
      nil -> {:error, "Employee not found"}
      employee -> {:ok, employee}
    end
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case EmployeeRepository.find_employee_by_id(id) do
      nil -> {:error, "Employee not found"}
      employee -> {:ok, employee}
    end
  end
end
