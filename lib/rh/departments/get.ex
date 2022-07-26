defmodule Rh.Departments.Get do
  @moduledoc """
  Get a department.
  """

  alias Rh.Repo
  alias Rh.Schema.Department

  alias Ecto.UUID

  def by_id(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  def get_by_code(code) do
    case Repo.get_by(Department, code: code) do
      nil -> {:error, "Department not found"}
      department -> {:ok, department}
    end
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Department, id) do
      nil -> "Department not found"
      departments -> {:ok, departments}
    end
  end
end
