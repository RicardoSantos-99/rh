defmodule Rh.CostCenters.Delete do
  @moduledoc """
  Delete a cost center.
  """

  alias Rh.Repo
  alias Rh.Schema.CostCenter

  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid UUID"}

  defp handle_response({:ok, id}) do
    case Repo.get(CostCenter, id) do
      nil -> {:error, "Cost center not found"}
      cost_center -> Repo.delete(cost_center)
    end
  end
end
