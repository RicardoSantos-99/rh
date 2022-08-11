defmodule Rh.Employees.Get do
  alias Rh.Repo
  alias Rh.Schema.Employee

  alias Ecto.UUID

  def by_id(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Employee, id) do
      nil -> {:error, "Employee not found"}
      employee -> {:ok, employee}
    end
  end
end
