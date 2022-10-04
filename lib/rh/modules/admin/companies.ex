defmodule Rh.Modules.Admin.Companies do
  alias Ecto.UUID
  alias Rh.Repo
  alias Rh.Schema.{Company, User}

  @spec create_company(Company.t(), User.t()) :: Company.t()
  def create_company(params, %User{}) do
    params
    |> Company.changeset()
    |> Repo.insert()
  end

  def create_company(_params, _), do: {:error, "Access denied"}

  def delete_company(id, %User{}) do
    id
    |> UUID.cast()
    |> handle_delete_response()
  end

  def delete_company(_params, _), do: {:error, "Access denied"}

  def find_by_id(id, _current_user) do
    id
    |> UUID.cast()
    |> handle_find_response()
  end

  def find_by_cnpj(cnpj, _current_user) do
    case Repo.get_by(Company, cnpj: cnpj) do
      nil -> {:error, "Company not found"}
      company -> {:ok, company}
    end
  end

  def list(_current_user) do
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
