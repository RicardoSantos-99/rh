defmodule RhWeb.Resolvers.Affiliate do
  @moduledoc """
  This module defines the affiliate resolver.
  """
  def get(%{id: affiliate_id}, _context), do: Rh.get_affiliate(affiliate_id)
  def create(%{input: params}, _context), do: Rh.create_affiliate(params)
  def delete(%{id: affiliate_id}, _context), do: Rh.delete_affiliate(affiliate_id)

  def list(_params, _args, %{context: %{current_user: current_user}}) do
    Rh.list_affiliates(current_user)
  end

  def list(_, _, _) do
    {:error, "Access denied"}
  end
end
