defmodule Rh.Companies.Get do
  @moduledoc """
  Get a company.
  """
  alias Rh.Repo
  alias Rh.Schema.Company

  alias Ecto.UUID

  def by_id(id, _current_user) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  def by_cnpj(cnpj, _current_user) do
    case Repo.get_by(Company, cnpj: cnpj) do
      nil -> {:error, "Company not found"}
      company -> {:ok, company}
    end
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(Company, id) do
      nil -> {:error, "Company not found"}
      company -> {:ok, company}
    end
  end
end
