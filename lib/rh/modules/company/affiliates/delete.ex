defmodule Rh.Modules.Company.Affiliates.Delete do
  @moduledoc """
  Delete an affiliate.
  """

  import Rh.Repositories.AffiliateRepository

  alias Ecto.UUID
  alias Rh.Repo
  alias Rh.Schema.Affiliate
  alias Rh.Utils.Auth

  def call(affiliate_id, current_user) do
    with %Affiliate{company_id: company_id} = affiliate <- find_affiliate_by_id(affiliate_id),
         {:ok, _id} <- Auth.check_access(company_id, current_user, :ADMIN),
         {:ok, _uuid} <- UUID.cast(affiliate_id) do
      Repo.delete(affiliate)
    else
      nil -> {:error, "Affiliate not found"}
      {:error, message} -> {:error, message}
      :error -> {:error, "Invalid UUID"}
    end
  end
end
