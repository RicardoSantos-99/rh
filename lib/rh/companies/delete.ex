defmodule Rh.Companies.Delete do
  @moduledoc """
  Delete a company.
  """

  alias Rh.Repo
  alias Rh.Schema.{Company, User}

  alias Ecto.UUID

  def call(id, %User{}) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  def call(_params, _), do: {:error, "Access denied"}

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Company, id) do
      nil -> {:error, "Company not found"}
      company -> Repo.delete(company)
    end
  end
end
