defmodule RhWeb.Resolvers.Affiliate do
  @moduledoc """
  This module defines the affiliate resolver.
  """
  def get(_params, %{id: affiliate_id}, %{context: %{current_user: current_user}}) do
    Rh.get_affiliate(affiliate_id, current_user)
  end

  def get(_, _, _), do: {:error, "Access denied"}

  def create(_params, %{input: params}, %{context: %{current_user: current_user}}) do
    Rh.create_affiliate(params, current_user)
  end

  def create(_, _, _), do: {:error, "Access denied"}

  def delete(_params, %{id: affiliate_id}, %{context: %{current_user: current_user}}) do
    Rh.delete_affiliate(affiliate_id, current_user)
  end

  def delete(_, _, _), do: {:error, "Access denied"}

  def list(_params, args, %{context: %{current_user: current_user}}) do
    Rh.list_affiliates(args, current_user)
  end

  def list(_, _, _), do: {:error, "Access denied"}
end
