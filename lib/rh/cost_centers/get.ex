defmodule Rh.CostCenters.Get do
  @moduledoc """
  Get a cost center.
  """

  alias Rh.Repo
  alias Rh.Schema.CostCenter

  alias Ecto.UUID

  def by_id(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  def get_by_code(code) do
    case Repo.get_by(CostCenter, code: code) do
      nil -> {:error, "Cost center not found"}
      cost_center -> {:ok, cost_center}
    end
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(CostCenter, id) do
      nil -> {:error, "Cost center not found"}
      cost_center -> {:ok, cost_center}
    end
  end
end
