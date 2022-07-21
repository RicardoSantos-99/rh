defmodule RhWeb.Resolvers.Affiliate do
  def get(%{id: affiliate_id}, _context), do: Rh.get_affiliate(affiliate_id)
  def create(%{input: params}, _context), do: Rh.create_affiliate(params)
  def delete(%{id: affiliate_id}, _context), do: Rh.delete_affiliate(affiliate_id)
  def list(_params, _context), do: Rh.list_affiliates()
end
