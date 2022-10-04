defmodule Rh.Modules.Company.Occupations.Create do
  @moduledoc """
  Create an occupation.
  """

  alias Rh.Repo
  alias Rh.Schema.{Company, Occupation}

  alias Ecto.UUID

  def call(%{company_id: company_id} = params) do
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

  def handle_insert(params) do
    params
    |> Occupation.changeset()
    |> Repo.insert()
  end
end
