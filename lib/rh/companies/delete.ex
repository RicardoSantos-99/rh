defmodule Rh.Companies.Delete do
  @moduledoc """
  Delete a company.
  """

  alias Rh.Repo
  alias Rh.Schema.Company

  alias Ecto.UUID

  def call(id, _current_user) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Company, id) do
      nil -> {:error, "Company not found"}
      company -> Repo.delete(company)
    end
  end
end
