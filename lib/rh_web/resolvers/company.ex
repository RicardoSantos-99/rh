defmodule RhWeb.Resolvers.Company do
  @moduledoc """
  This module defines the company resolver.
  """
  def get(%{id: company_id}, _context), do: Rh.get_company(company_id)
  def create(%{input: params}, _context), do: Rh.create_company(params)
  def delete(%{id: company_id}, _context), do: Rh.delete_company(company_id)
  def list(_params, _context), do: Rh.list_companies()
  def get_by_cnpj(%{cnpj: cnpj}, _context), do: Rh.get_company_by_cnpj(cnpj)
end
