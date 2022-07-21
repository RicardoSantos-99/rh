defmodule RhWeb.Queries.Affiliate do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Affiliate, as: AffiliateResolver

  object :affiliate_queries do
    field :get_affiliate, type: :affiliate do
      arg :id, non_null(:uuid4)

      resolve &AffiliateResolver.get/2
    end

    field :list_affiliates, list_of(:affiliate) do
      resolve &AffiliateResolver.list/2
    end
  end
end
