defmodule RhWeb.Resolvers.User do
  def login(params, _context), do: Rh.user_login(params)

  def user_create_employee(_params, %{input: params}, %{context: %{current_user: current_user}}) do
    Rh.user_create_employee(params, current_user)
  end

  def user_create_employee(_, _, _), do: {:error, "Access denied"}

  def user_create_affiliate(_params, %{input: params}, %{context: %{current_user: current_user}}) do
    Rh.user_create_affiliate(params, current_user)
  end

  def user_create_affiliate(_, _, _), do: {:error, "Access denied"}

  def user_create_company(_params, %{input: params}, %{context: %{current_user: current_user}}) do
    Rh.user_create_company(params, current_user)
  end

  def user_create_company(_, _, _), do: {:error, "Access denied"}

  def create_occupation(_params, %{input: params}, %{context: %{current_user: current_user}}) do
    Rh.user_create_occupation(params, current_user)
  end

  def create_occupation(_, _, _), do: {:error, "Access denied"}

  # def logout(_params, %{context: %{current_user: current_user}}), do: Rh.logout(current_user)

  # def logout(_params, _context), do: {:error, "not logged in"}
end
