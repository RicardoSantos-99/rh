defmodule Rh.Modules.Company.CostCenters.List do
  @moduledoc """
  List cost centers.
  """
  alias Rh.Repo
  alias Rh.Schema.CostCenter

  def call do
    Repo.all(CostCenter)
    |> handle_response()
  end

  defp handle_response(cost_center), do: {:ok, cost_center}
end
