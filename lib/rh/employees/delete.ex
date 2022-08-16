defmodule Rh.Employees.Delete do
  @moduledoc """
    Delete an Employees.
  """
  alias Rh.Repo
  alias Rh.Schema.Employee

  alias Ecto.UUID

  def call(id, _current_user) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Employee, id) do
      nil -> {:error, "Employee not found"}
      employee -> Repo.delete(employee)
    end
  end
end
