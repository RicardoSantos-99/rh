defmodule Rh.Modules.Admin.Companies do
  alias Ecto.UUID
  alias Rh.Repo
  alias Rh.Schema.Company

  @spec create_company(Company.t()) :: Company.t()
  def create_company(params) do
    params
    |> Company.changeset()
    |> Repo.insert()
  end

  def delete_company(id) do
    id
    |> UUID.cast()
    |> handle_delete_response()
  end

  def find_by_id(id) do
    id
    |> UUID.cast()
    |> handle_find_response()
  end

  def find_by_cnpj(cnpj) do
    case Repo.get_by(Company, cnpj: cnpj) do
      nil -> {:error, "Company not found"}
      company -> {:ok, company}
    end
  end

  def list do
    Repo.all(Company)
    |> handle_list_response()
  end

  defp handle_list_response(companies), do: {:ok, companies}

  defp handle_find_response(:error), do: {:error, "Invalid UUID"}

  defp handle_find_response({:ok, id}) do
    case Repo.get(Company, id) do
      nil -> {:error, "Company not found"}
      company -> {:ok, company}
    end
  end

  defp handle_delete_response(:error), do: {:error, "Invalid UUID"}

  defp handle_delete_response({:ok, id}) do
    case Repo.get(Company, id) do
      nil -> {:error, "Company not found"}
      company -> Repo.delete(company)
    end
  end
end
