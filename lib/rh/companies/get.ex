defmodule Rh.Companies.Get do
  alias Rh.Repo
  alias Rh.Schema.Company

  alias Ecto.UUID

  def by_id(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  def by_cnpj(cnpj) do
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
