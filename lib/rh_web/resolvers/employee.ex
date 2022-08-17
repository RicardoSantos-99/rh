defmodule RhWeb.Resolvers.Employee do
  @moduledoc """
  This module defines the employees resolver.
  """
  def login(params, _context), do: Rh.login(params)

  def logout(_params, %{context: %{current_user: current_user}}), do: Rh.logout(current_user)

  def logout(_params, _context), do: {:error, "not logged in"}

  def get(_params, %{id: affiliate_id}, %{context: %{current_user: current_user}}) do
    Rh.get_employee(affiliate_id, current_user)
  end

  def get(_, _, _), do: {:error, "Access denied"}

  def get_by_email(_params, %{email: email}, %{context: %{current_user: current_user}}) do
    Rh.get_by_email(email, current_user)
  end

  def get_by_email(_, _, _), do: {:error, "Access denied"}

  def create(_params, %{input: params}, %{context: %{current_user: current_user}}) do
    Rh.create_employee(params, current_user)
  end

  def create(_, _, _), do: {:error, "Access denied"}

  def delete(_params, %{id: affiliate_id}, %{context: %{current_user: current_user}}) do
    Rh.delete_employee(affiliate_id, current_user)
  end

  def delete(_, _, _), do: {:error, "Access denied"}

  def list(_params, _args, %{context: %{current_user: current_user}}) do
    Rh.list_employees(current_user)
  end

  def list(_, _, _), do: {:error, "Access denied"}
end
