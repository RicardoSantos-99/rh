defmodule Rh.Affiliates.List do
  @moduledoc """
  List affiliates.
  """
  import Rh.Repositories.AffiliateRepository
  alias Rh.Utils.Auth
  alias Rh.Schema.{Employee, User}

  def call(_, %Employee{company_id: company_id} = current_user) do
    case Auth.check_access(company_id, current_user, :ADMIN) do
      {:ok, _id} ->
        company_id
        |> find_affiliate_by_company_id
        |> handle_response

      {:error, message} ->
        {:error, message}
    end
  end

  def call(%{company_id: company_id}, %User{}) do
    company_id
    |> find_affiliate_by_company_id
    |> handle_response
  end

  def call(_, _), do: {:error, "No company id"}

  defp handle_response(affiliates), do: {:ok, affiliates}
end
