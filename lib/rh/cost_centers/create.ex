defmodule Rh.CostCenters.Create do
  alias Rh.Repo
  alias Rh.Schema.CostCenter

  def call(params) do
    params
    |> CostCenter.changeset()
    |> Repo.insert()
  end
end
