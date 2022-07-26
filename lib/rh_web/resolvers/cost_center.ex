defmodule RhWeb.Resolvers.CostCenter do
  @moduledoc """
  This module defines the cost center resolver.
  """
  def get(%{id: cost_center_id}, _context), do: Rh.get_cost_center(cost_center_id)
  def create(%{input: params}, _context), do: Rh.create_cost_center(params)
  def delete(%{id: cost_center_id}, _context), do: Rh.delete_cost_center(cost_center_id)
  def list(_params, _context), do: Rh.list_cost_centers()
  def get_by_code(%{code: code}, _context), do: Rh.get_cost_center_by_code(code)
end
