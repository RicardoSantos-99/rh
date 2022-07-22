defmodule Rh.Affiliates.Create do
  alias Rh.Repo
  alias Rh.Schema.{Affiliate, Company}

  alias Ecto.UUID

  def call(%{name: name, cnpj: cnpj, company_id: company_id}) do
    params = %{name: name, cnpj: cnpj, company_id: company_id}

    company_id
    |> UUID.cast()
    |> handle_response(params)
  end

  defp handle_response(:error, _params), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, company_id}, params) do
    case Repo.get(Company, company_id) do
      nil -> {:error, "Company not found"}
      _company -> handle_insert(params)
    end
  end

  defp handle_insert(params) do
    params
    |> Affiliate.changeset()
    |> Repo.insert()
  end
end
