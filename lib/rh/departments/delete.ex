defmodule Rh.Departments.Delete do
  @moduledoc """
  Delete a department.
  """

  alias Rh.Repo
  alias Rh.Schema.Department

  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Department, id) do
      nil -> {:error, "Department not found"}
      department -> Repo.delete(department)
    end
  end
end
