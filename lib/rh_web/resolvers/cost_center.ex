defmodule RhWeb.Resolvers.CostCenter do
  @moduledoc """
  This module defines the cost center resolver.
  """
  def get(%{id: cost_center_id}, _context), do: Rh.get_cost_center(cost_center_id)

  def create(_params, %{input: params}, %{context: %{current_user: current_user}}) do
    Rh.create_cost_center(params, current_user)
  end

  def create(_, _, _), do: {:error, "Access denied"}

  def delete(%{id: cost_center_id}, _context), do: Rh.delete_cost_center(cost_center_id)
  def list(_params, _context), do: Rh.list_cost_centers()
  def get_by_code(%{code: code}, _context), do: Rh.get_cost_center_by_code(code)
end
