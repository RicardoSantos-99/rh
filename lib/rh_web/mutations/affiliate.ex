defmodule RhWeb.Mutations.Affiliate do
  use Absinthe.Schema.Notation

  alias RhWeb.Resolvers.Affiliate, as: AffiliateResolver

  alias Crudry.Middlewares.TranslateErrors

  object :affiliate_mutation do
    field :create_affiliate, type: :affiliate do
      arg :input, non_null(:create_affiliate_input)

      resolve &AffiliateResolver.create/2
      middleware TranslateErrors
    end

    field :delete_affiliate, type: :affiliate do
      arg :id, non_null(:uuid4)

      resolve &AffiliateResolver.delete/2
      middleware TranslateErrors
    end
  end
end
