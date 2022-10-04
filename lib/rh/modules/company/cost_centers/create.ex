defmodule Rh.Modules.Company.CostCenters.Create do
  @moduledoc """
  Create a cost center.
  """
  alias Ecto.UUID
  alias Rh.Repo
  alias Rh.Schema.CostCenter
  alias Rh.Utils.Auth

  def call(%{affiliate_id: affiliate_id} = params, current_user) do
    with {:ok, _id} <- Auth.check_access(current_user, :ADMIN),
         {:ok, _uuid} <- UUID.cast(affiliate_id) do
      handle_insert(params)
    else
      {:error, message} -> {:error, message}
      :error -> {:error, "Invalid UUID"}
    end
  end

  defp handle_insert(params) do
    params
    |> CostCenter.changeset()
    |> Repo.insert()
  end
end
