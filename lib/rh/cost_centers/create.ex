defmodule Rh.CostCenters.Create do
  alias Rh.Repo
  alias Rh.Schema.{Affiliate, CostCenter}

  alias Ecto.UUID

  def call(%{affiliate_id: affiliate_id} = params) do
    affiliate_id
    |> UUID.cast()
    |> handle_response(params)
  end

  defp handle_response(:error, _params), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, affiliate_id}, params) do
    case Repo.get(Affiliate, affiliate_id) do
      nil -> {:error, "Affiliate not found"}
      _company -> handle_insert(params)
    end
  end

  defp handle_insert(params) do
    params
    |> CostCenter.changeset()
    |> Repo.insert()
  end
end
