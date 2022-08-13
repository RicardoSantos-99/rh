defmodule Rh.Repositories.AffiliateRepository do
  import Ecto.Query

  alias Rh.Repo
  alias Rh.Schema.Affiliate

  def find_affiliate_by_id(affiliate_id) do
    Repo.one(
      from a in Affiliate,
        where: a.id == ^affiliate_id
    )
  end

  def find_affiliate_by_company_id(company_id) do
    Repo.all(
      from a in Affiliate,
        where: a.company_id == ^company_id
    )
  end

  def remove_affiliate_by_id(affiliate_id) do
    Repo.delete_all(
      from a in Affiliate,
        where: a.id == ^affiliate_id
    )
  end
end
