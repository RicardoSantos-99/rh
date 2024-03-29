defmodule RhWeb.Resolvers.Company do
  @moduledoc """
  This module defines the company resolver.
  """
  def get(_params, %{id: company_id}, %{context: %{current_user: _current_user}}) do
    Rh.get_company(company_id)
  end

  def create(_params, %{input: params}, %{context: %{current_user: _current_user}}) do
    Rh.create_company(params)
  end

  def create(_, _, _), do: {:error, "Access denied"}

  def delete(_params, %{id: company_id}, %{context: %{current_user: _current_user}}) do
    Rh.delete_company(company_id)
  end

  def delete(_, _, _), do: {:error, "Access denied"}

  def list(_params, %{context: %{current_user: _current_user}}) do
    Rh.list_companies()
  end

  def list(_, _, _), do: {:error, "Access denied"}

  def get_by_cnpj(_params, %{cnpj: cnpj}, %{context: %{current_user: _current_user}}) do
    Rh.get_company_by_cnpj(cnpj)
  end

  def get_by_cnpj(_, _, _), do: {:error, "Access denied"}
end
