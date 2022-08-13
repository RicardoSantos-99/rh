defmodule Rh.Affiliates.List do
  @moduledoc """
  List affiliates.
  """
  import Rh.Repositories.AffiliateRepository
  alias Rh.Schema.Employee

  def call(%Employee{company_id: company_id}) do
    company_id
    |> find_affiliate_by_company_id
    |> handle_response
  end

  defp handle_response(affiliates), do: {:ok, affiliates}
end
