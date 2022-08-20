defmodule RhWeb.Queries.Affiliate do
  @moduledoc """
  affiliate queries.
  """
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Affiliate, as: AffiliateResolver

  object :affiliate_queries do
    field :get_affiliate, type: :affiliate do
      arg :id, non_null(:uuid4)

      resolve &AffiliateResolver.get/3
    end

    field :list_affiliates, list_of(:affiliate) do
      arg :company_id, :uuid4
      resolve &AffiliateResolver.list/3
    end
  end
end
