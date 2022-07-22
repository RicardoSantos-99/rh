defmodule Rh.CostCenters.List do
  alias Rh.Repo
  alias Rh.Schema.CostCenter

  def call() do
    Repo.all(CostCenter)
    |> handle_response()
  end

  defp handle_response(cost_center), do: {:ok, cost_center}
end
